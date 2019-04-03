
class Protocol {

  final List<int> _datas = [];
  final int action;

  Protocol({this.action});

  Protocol appendInt7(int byte) {
    _datas.add(byte);
    return this;
  }

  Protocol appendInt14(int d) {
    _datas.add((d >> 7) & 0x7F);
    _datas.add(d & 0x7F);
    return this;
  }

  List<int> build() {
    var c = 0;
    final list = [0xE1, _datas.length + 5, action];
    _datas.forEach((d) {
      c ^= d;
      list.add(d);
    });
    list.add(c);
    list.add(0xEF);
    return list;
  }

}
