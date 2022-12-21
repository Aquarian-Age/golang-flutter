class Group {
  String id;
  String name;
  String time;

  Group({required this.id, required this.name, required this.time});

  Group.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        time = json["time"];
}
  // factory Group.fromjson(data) {
  //   Group grp = Group(id: '', name: '', time: '');
  //   grp.id = data['id'];
  //   grp.name = data['name'];
  //   grp.time = data['time'];
  //   return grp;
  // }
