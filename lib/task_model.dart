class TaskModel {
  static const String collectionName="Task";
  String id;
  String title;
  String description;
  bool? isDone;
  int? date;
  String userId;

  TaskModel({
    required this.date,
    required this.userId,
    required this.description,
    this.id = "",
    this.isDone = false,
    required this.title,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          date: json['date'],
          userId: json['userId'],
          description: json['description'],
          title: json['title'],
          isDone: json['isDone'],
          id: json['id'],
        );

  //TaskModel fromJson(Map<String, dynamic>json) {
  //return TaskModel(
  // date: json['date'],
  //   description: json['description'],
  // title: json['title'],
//isDone: json['isDone'],
  // id: json['id'],
  // );
  // }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "title": title,
      "date": date,
      "id": id,
      "userId": userId,
      "isDone": isDone,
    };
  }
}
