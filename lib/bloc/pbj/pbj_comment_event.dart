abstract class PBJCommentEvent {}

class GetKomentarPBJ extends PBJCommentEvent {
  final String noPermintaan;

  GetKomentarPBJ({
    required this.noPermintaan,
  });
}
