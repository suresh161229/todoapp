class TodoModel{
  String? image;

  String? workshop;
  String? place;
  String? time;
  String? notification;
  String? type;

  TodoModel({this.notification,this.place,this.time,this.workshop,this.type,this.image});

  Map<String, dynamic> toMap() => {
    "workshop":workshop,
    "place": place,
    "time": time,
    "notification": notification,
    "type": type,
    "image": image,

  };

}