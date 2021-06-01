class BibleVerseResponse {
  Verse verse;

  BibleVerseResponse({this.verse});

  BibleVerseResponse.fromJson(Map<String, dynamic> json) {
    verse = json['verse'] != null ? new Verse.fromJson(json['verse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verse != null) {
      data['verse'] = this.verse.toJson();
    }
    return data;
  }
}

class Verse {
  Details details;
  String notice;

  Verse({this.details, this.notice});

  Verse.fromJson(Map<String, dynamic> json) {
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    notice = json['notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['notice'] = this.notice;
    return data;
  }
}

class Details {
  String text;
  String reference;
  String version;
  String verseurl;

  Details({this.text, this.reference, this.version, this.verseurl});

  Details.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    reference = json['reference'];
    version = json['version'];
    verseurl = json['verseurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['reference'] = this.reference;
    data['version'] = this.version;
    data['verseurl'] = this.verseurl;
    return data;
  }
}