class HadithResponse {
  final int status;
  final String message;
  final Hadiths hadiths;

  HadithResponse({
    required this.status,
    required this.message,
    required this.hadiths,
  });

  factory HadithResponse.fromJson(Map<String, dynamic> json) {
    return HadithResponse(
      status: json['status'],
      message: json['message'],
      hadiths: Hadiths.fromJson(json['hadiths']),
    );
  }
}

class Hadiths {
  final int currentPage;
  final List<Hadith> data;

  Hadiths({
    required this.currentPage,
    required this.data,
  });

  factory Hadiths.fromJson(Map<String, dynamic> json) {
    return Hadiths(
      currentPage: json['current_page'],
      data: List<Hadith>.from(json['data'].map((x) => Hadith.fromJson(x))),
    );
  }
}

class Hadith {
  final int id;
  final String hadithNumber;
  final String englishNarrator;
  final String hadithEnglish;
  final String hadithUrdu;

  Hadith({
    required this.id,
    required this.hadithNumber,
    required this.englishNarrator,
    required this.hadithEnglish,
    required this.hadithUrdu,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'],
      hadithNumber: json['hadithNumber'],
      englishNarrator: json['englishNarrator'],
      hadithEnglish: json['hadithEnglish'],
      hadithUrdu: json['hadithUrdu'],
    );
  }
}
