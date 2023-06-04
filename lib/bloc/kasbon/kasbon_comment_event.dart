abstract class KasbonCommentEvent {}

class GetKomentarKasbon extends KasbonCommentEvent {
  final String noKasbon;

  GetKomentarKasbon({
    required this.noKasbon,
  });
}
