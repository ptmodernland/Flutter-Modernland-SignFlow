abstract class RealisasiCommentEvent {}

class GetKomentarRealisasi extends RealisasiCommentEvent {
  final String noRealisasi;

  GetKomentarRealisasi({
    required this.noRealisasi,
  });
}
