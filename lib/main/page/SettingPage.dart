import 'package:flutter/material.dart';
import 'TestPage.dart';
import '../../data/DeviceStatus.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BodyState();
  }
}

class _BodyState extends State<_Body> with AutomaticKeepAliveClientMixin {

  final tempValueTextStyle = TextStyle(
    color: Colors.redAccent,
    fontSize: 15,
  );

  final textStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  @override
  bool get wantKeepAlive {
    return true;
  }

  DeviceStatus _status = DeviceStatus.normal();

  void _onClickReadGoodsTypeData() {}

  void _onClickSettingGoodsTypeData() {}

  void _onClickAddGoodsTypeData() {}

  Widget _itemBuilder(BuildContext context, int index) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[

        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            children: <Widget>[
              Text('机械臂1实际位置:', style: textStyle,),
              Expanded(
                child: Text(
                  '${_status.position1}',
                  style: tempValueTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Text('机械臂2实际位置:', style: textStyle,),
              Expanded(
                child: Text(
                  '${_status.position2}',
                  style: tempValueTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          flex: 13,
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: 0,
          ),
        ),

        Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: textButtonCreate(_onClickReadGoodsTypeData, '读取货道数据',
                    EdgeInsets.fromLTRB(0, 0, 10, 0)),
              ),
              Expanded(
                child: textButtonCreate(_onClickSettingGoodsTypeData, '一键设置货道',
                    EdgeInsets.fromLTRB(0, 0, 10, 0)),
              ),
              Expanded(
                child: textButtonCreate(_onClickAddGoodsTypeData, '增加货道',
                    EdgeInsets.fromLTRB(0, 0, 0, 0)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    print('Setting Page 初始化');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Setting Page 消除');
  }

}
