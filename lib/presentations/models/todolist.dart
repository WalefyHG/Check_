import 'package:uuid/uuid.dart';

class TodoModel{
  final String id;
  final String title;
  final String? description;
  final String? date;
  final bool isDone;

  TodoModel(this.title, {String? descriptionC, String? dateC , String? idC, bool? isDoneC}):
    id = idC ?? const Uuid().v4(),
    isDone = isDoneC ?? false,
    description = descriptionC,
    date = dateC;

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    bool? isDone,

}){
    return TodoModel(
      title ?? this.title,
      descriptionC: description ?? this.description,
      idC: id ?? this.id,
      dateC: date ?? this.date,
      isDoneC: isDone ?? this.isDone,
    );
  }
}