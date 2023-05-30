abstract class CompareCommentEvent {}

class GetKomentarCompare extends CompareCommentEvent {
  final String noCompare;

  GetKomentarCompare({
    required this.noCompare,
  });
}
