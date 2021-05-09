class EventModel {
  final int id;
  final String title, desc, imageUrl, venue, date, endTime, startTime;

  EventModel({
    this.id,
    this.title,
    this.desc,
    this.venue,
    this.imageUrl,
    this.date,
    this.endTime,
    this.startTime
  });

  factory EventModel.fromJson(Map<String, dynamic> jsonData) {
    return EventModel(
      id: jsonData['id'],
      title: jsonData['title'],
      desc: jsonData['description'],
      venue: jsonData['location'],
      imageUrl: jsonData['photo'],
      date: jsonData['date'],
      endTime: jsonData['end_time'],
      startTime: jsonData['start_time'],
    );
  }
}