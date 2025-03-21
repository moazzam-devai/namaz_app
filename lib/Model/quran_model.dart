class QuranResponse {
  final int code;
  final String status;
  final Data data;

  QuranResponse({required this.code, required this.status, required this.data});

  factory QuranResponse.fromJson(Map<String, dynamic> json) {
    return QuranResponse(
      code: json['code'],
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final List<Surah> surahs;

  Data({required this.surahs});

  factory Data.fromJson(Map<String, dynamic> json) {
    var surahList = json['surahs'] as List;
    List<Surah> surahItems = surahList.map((i) => Surah.fromJson(i)).toList();
    return Data(surahs: surahItems);
  }
}

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final List<Ayah> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    var ayahList = json['ayahs'] as List;
    List<Ayah> ayahItems = ayahList.map((i) => Ayah.fromJson(i)).toList();
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      ayahs: ayahItems,
    );
  }
}

class Ayah {
  final int number;
  final String text;
  final String audio;
  final String audioSecondary;

  Ayah({
    required this.number,
    required this.text,
    required this.audio,
    required this.audioSecondary,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'],
      text: json['text'],
      audio: json['audio'],
      audioSecondary: json['audioSecondary'][0],
    );
  }
}
