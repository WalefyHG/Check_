import 'package:uuid/uuid.dart';

class TodoModel{
  final String id;
  final String title;
  final String? description;
  final DateTime? date;
  late bool hasAlarm;
  late bool isDone;

  TodoModel(this.title, {String? descriptionC, DateTime? dateC , String? idC, bool? isDoneC}):
    id = idC ?? const Uuid().v4(),
    isDone = isDoneC ?? false,
    description = descriptionC,
    hasAlarm = false,
    date = dateC;

  TodoModel.fromJson(Map<String, dynamic> json):
    id = json['id'],
    title = json['title'],
    description = json['description'],
    date = json['date'] != null ? DateTime.parse(json['date'] as String) : null,
    hasAlarm = json['hasAlarm'],
    isDone = json['isDone'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date?.toIso8601String(),
    'hasAlarm': hasAlarm,
    'isDone': isDone,
  };
}