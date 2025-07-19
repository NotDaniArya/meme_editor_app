import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meme_editor_app/features/meme/presentation/notifiers/meme_notifier.dart';
import 'package:meme_editor_app/features/meme/presentation/providers/meme_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => ref.read(memeNotifierProvider.notifier).fetchMemes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final memeState = ref.watch(memeNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Editor'),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          // Tombol refresh manual jika diperlukan
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(memeNotifierProvider.notifier).fetchMemes();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: RefreshIndicator(
          child: _buildBody(context, memeState),
          onRefresh: () => ref.read(memeNotifierProvider.notifier).fetchMemes(),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, MemeState state) {
    if (state is MemeLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MemeLoaded) {
      return GridView.builder(
        padding: const EdgeInsetsGeometry.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: state.memes.length,
        itemBuilder: (context, index) {
          final meme = state.memes[index];
          return GestureDetector(
            onTap: () {
              context.push('/editor', extra: meme);
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: meme.url,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
      );
    } else if (state is MemeError) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Center(child: Text('Gagal memuat: ${state.message}')),
            ),
          ),
        ],
      );
    }
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: const Center(child: Text('Geser kebawah untuk memuat data')),
        ),
      ],
    );
  }
}
