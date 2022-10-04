class Media {
  final int id;
  final String image;
  final String? video;

  Media({
    required this.id,
    required this.image,
    // required this.video,
    this.video,
  });
}
