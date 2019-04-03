import 'package:flutter/material.dart';
import '../../data/DeviceStatus.dart';
import 'TestPage.dart';

Widget tapButtonCreate(
    VoidCallback tapDown, VoidCallback tapUp, String text, EdgeInsets padding) {
  return Padding(
      padding: padding,
      child: GestureDetector(
        onTapDown: (v) {
          tapDown();
        },
        onTapCancel: () {
          tapUp();
        },
        onTapUp: (v) {
          tapUp();
        },
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.lightBlueAccent,
          highlightColor: Colors.blueGrey,
          padding: EdgeInsets.all(15),
          textColor: Colors.white,
          onPressed: () {},
          child: Text(text),
        ),
      ));
}

class RobotArmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
  final textStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  final tempValueTextStyle = TextStyle(
    color: Colors.redAccent,
    fontSize: 15,
  );

  final titleStyle = TextStyle(
    color: Colors.orangeAccent,
    fontSize: 30,
  );

  @override
  bool get wantKeepAlive {
    return true;
  }

  DeviceStatus _status = DeviceStatus.normal();

  void _onClickPositionCheck() {}

  void _onClickAutoLocation() {}

  void _onClickDelivery() {}

  void _onStartLeft1() {}

  void _onStartRight1() {}

  void _onBrake1() {}

  void _onStartLeft2() {}

  void _onStartRight2() {}

  void _onBrake2() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '机械臂1实际位置:',
                  style: textStyle,
                ),
                Expanded(
                  child: Text(
                    '${_status.position1}',
                    textAlign: TextAlign.center,
                    style: tempValueTextStyle,
                  ),
                ),
                Text(
                  '机械臂2实际位置:',
                  style: textStyle,
                ),
                Expanded(
                  child: Text(
                    '${_status.position2}',
                    textAlign: TextAlign.center,
                    style: tempValueTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '手动校准',
            style: titleStyle,
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '实际位置1',
                  style: textStyle,
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text(
                  '实际位置2',
                  style: textStyle,
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(''),
              ),
              Expanded(
                flex: 2,
                child: textButtonCreate(
                    _onClickPositionCheck, '开始位置校准', EdgeInsets.all(5)),
              ),
              Expanded(
                child: Text(''),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '机械臂自动定位能力测试',
            style: titleStyle,
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '位置1:',
                  style: textStyle,
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '位置2:',
                  style: textStyle,
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(''),
              ),
              Expanded(
                flex: 2,
                child: textButtonCreate(
                    _onClickAutoLocation, '开始自动定位', EdgeInsets.all(5)),
              ),
              Expanded(
                child: Text(''),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '行:',
                  style: textStyle,
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '列:',
                  style: textStyle,
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: textButtonCreate(
                      _onClickDelivery, '出货', EdgeInsets.fromLTRB(10, 0, 0, 0)),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '手动控制',
            style: titleStyle,
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: tapButtonCreate(_onStartLeft1, _onBrake1, '手臂1左转',
                    EdgeInsets.fromLTRB(5, 0, 5, 0)),
              ),
              Expanded(
                child: tapButtonCreate(_onStartRight1, _onBrake1, '手臂1右转',
                    EdgeInsets.fromLTRB(5, 0, 5, 0)),
              ),
              Expanded(
                child: textButtonCreate(
                    _onBrake1, '手臂1刹车', EdgeInsets.fromLTRB(5, 0, 5, 0)),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: tapButtonCreate(_onStartLeft2, _onBrake2, '手臂2左转',
                    EdgeInsets.fromLTRB(5, 0, 5, 0)),
              ),
              Expanded(
                child: tapButtonCreate(_onStartRight2, _onBrake2, '手臂2右转',
                    EdgeInsets.fromLTRB(5, 0, 5, 0)),
              ),
              Expanded(
                child: textButtonCreate(
                    _onBrake2, '手臂2刹车', EdgeInsets.fromLTRB(5, 0, 5, 0)),
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
    print('RobotArm Page 初始化');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('RobotArm Page 消除');
  }


}
