class SoundItem {
  final String name; // название или ключ звука
  final String assetPath;// путь к аудиофайлу в ассетах
  final String imagePath; // путь к изображению звука

  const SoundItem({
    required this.name,
    required this.assetPath,
    required this.imagePath,
  });
}
