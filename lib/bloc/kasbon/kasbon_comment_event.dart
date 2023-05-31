abstract class CompareCommentEvent {}

class GetKomentarKasbon extends CompareCommentEvent {
  final String noCompare;

  GetKomentarKasbon({
    required this.noCompare,
  });
}
