import 'package:equatable/equatable.dart';

class Meme extends Equatable {
  const Meme({required this.id, required this.name, required this.url});

  final String id;
  final String name;
  final String url;

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, url];
}
