class TaskModel {
  int? id;
  String? title;
  String? date;
  String? time;
  String? status;

  TaskModel(this.title, this.date, this.time, this.status, {this.id = -1});

  static TaskModel fromMap(Map<dynamic, dynamic> map) {
    return TaskModel(map['title'], map['date'], map['time'], map['status'], id: map['id']);
  }

  @override
  String toString() {
    return "(id: $id, title: $title, date: $date, time: $time, status: $status )";
  }
}
