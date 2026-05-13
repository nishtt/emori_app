class MoodPack {
  final String id;   //идентификатор набора, например 'classic'   
  final String name;    //название набора   
  final String basePath;    //путь к папке с картинками 
  final String placeholder;  //файл с контуром для пустых дней   

  MoodPack({
    required this.id,
    required this.name,
    required this.basePath,
    required this.placeholder,
  });
}

