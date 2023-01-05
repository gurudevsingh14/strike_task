import 'menu_item_model.dart';

class SubTask{
  String? id;
  bool done=false;
  String? name;
  SubTask({this.name, this.done=false, this.id});
  factory SubTask.fromJson(Map<String, dynamic> data) {
    return SubTask(
        id: data['id'],
        name: data['name'],
        done: data['done']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'done': done,
    };
  }
}