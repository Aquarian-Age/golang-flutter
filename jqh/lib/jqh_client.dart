// 向服务端传送的数据
class CustomClass {
  final String times;
  final int stargn;
  final int doorgn;
  CustomClass({required this.times, required this.stargn, required this.doorgn});
  CustomClass.fromJson(Map<String, dynamic> json)
      : times = json['times'],
        stargn = json['stargn'],
        doorgn = json['doorgn'];

  static Map<String, dynamic> toJson(CustomClass data) => {'times': data.times, 'stargn': data.stargn, 'doorgn': data.doorgn};
}
