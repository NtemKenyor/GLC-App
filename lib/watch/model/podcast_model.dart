class Podcast {
  //final String id;
  final String pod_name, date, imageUrl, listen;

  Podcast({
    this.pod_name,
    this.date,
    this.imageUrl,
    this.listen,
  });

  factory Podcast.fromJson(Map<String, dynamic> jsonData) {
    return Podcast(
      pod_name: jsonData['title'],
      date: jsonData['date'],
      imageUrl: jsonData['photo'],
      listen: jsonData['file'],
    );
  }
}