class Task {
   String id ;
  final String info;
  final String date;
  final String time;
  final String created;
  Task({
     required this.id,
    required this.info,
    required this.date,
    required this.time,
    required this.created,
    

  });
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String, 
      date: json['date'] as String,
      time: json['time'] as String,
      info: json['info'] as String,
      created: json['created'] as String,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'info': info,
      'created':created,
    };
  }
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      date: map['date'],
      time: map['time'],
      info: map['info'],
      created: map['created']
    );
  } 
}