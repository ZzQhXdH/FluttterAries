import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../chart/BLEManager.dart';
import '../../data/Protocol.dart';
import '../../data/DeviceStatus.dart';
import '../../chart/Dialog.dart';

Widget textButtonCreate(
    VoidCallback onPressed, String text, EdgeInsets padding) {
  return Padding(
    padding: padding,
    child: MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.lightBlueAccent,
      highlightColor: Colors.blueGrey,
      padding: EdgeInsets.all(15),
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(text),
    ),
  );
}

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: _Body(),
      ),
      resizeToAvoidBottomPadding: false,
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

  DeviceStatus _status = DeviceStatus.normal();

  @override
  bool get wantKeepAlive {
    return true;
  }

  void _onClickCloseFridge() {
    final text = fridgeController.text;
    if (text.isEmpty) {
      showDialogWithTitle('请输入电机速度', context);
      return;
    }
    final sp = int.parse(text);
    final bytes = Protocol(action: 0x03)
        .appendInt7(0x01)
        .appendInt7(sp)
        .appendInt14(10000)
        .build();
    BLEManager.instance.write(bytes);
  }

  void _onClickOpenFridge() {
    final text = fridgeController.text;
    if (text.isEmpty) {
      showDialogWithTitle('请输入电机速度', context);
      return;
    }
    final sp = int.parse(text);
    final bytes = Protocol(action: 0x03)
        .appendInt7(0x00)
        .appendInt7(sp)
        .appendInt14(10000)
        .build();
    BLEManager.instance.write(bytes);
  }

  void _onClickUpPick() {
    var text = pickSpController.text;
    if (text.isEmpty) {
      showDialogWithTitle('请输入电机速度', context);
      return;
    }
    final sp = int.parse(text);
    text = pickStepController.text;
    if (text.isEmpty) {
      showDialogWithTitle('请输入脉冲个数', context);
      return;
    }
    final step = int.parse(text);
    final bytes = Protocol(action: 0x04)
      .appendInt7(0x00)
      .appendInt7(sp)
      .appendInt14(step)
      .appendInt14(10000)
      .build();
    BLEManager.instance.write(bytes);
  }

  void _onClickDownPick() {
    var text = pickSpController.text;
    if (text.isEmpty) {
      showDialogWithTitle('请输入电机速度', context);
      return;
    }
    final sp = int.parse(text);
    text = pickStepController.text;
    if (text.isEmpty) {
      showDialogWithTitle('请输入脉冲个数', context);
      return;
    }
    final step = int.parse(text);
    final bytes = Protocol(action: 0x04)
        .appendInt7(0x01)
        .appendInt7(sp)
        .appendInt14(step)
        .appendInt14(10000)
        .build();
    BLEManager.instance.write(bytes);
  }

  void _onClickCloseCompressor() {
    final bytes = Protocol(action: 0x05)
        .appendInt7(0x01)
        .build();
    BLEManager.instance.write(bytes);
  }

  void _onClickOpenCompressor() {
    final bytes = Protocol(action: 0x05)
          .appendInt7(0x00)
          .build();
    BLEManager.instance.write(bytes);
  }

  void _onClickOpenELock() {
    final bytes = Protocol(action: 0x0F).build();
    BLEManager.instance.write(bytes);
  }

  void _onClickInit() {
    final bytes = Protocol(action: 0x09)
          .appendInt14(10000)
          .build();
    BLEManager.instance.write(bytes);
  }

  final textStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  final tempValueTextStyle = TextStyle(
    color: Colors.redAccent,
    fontSize: 15,
  );

  final fridgeController = TextEditingController();
  final pickSpController = TextEditingController();
  final pickStepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(''),
              ),
              Text(
                '空压机吸到商品:',
                style: textStyle,
              ),
              Checkbox(
                value: _status.compressor,
                onChanged: (value) {},
              ),
              Expanded(
                flex: 2,
                child: Text(''),
              ),
              Text(
                '大门关闭:',
                style: textStyle,
              ),
              Checkbox(
                value: _status.doorClose,
                onChanged: (value) {},
              ),
              Expanded(
                child: Text(''),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(''),
              ),
              Text(
                '升降电机位于顶部:',
                style: textStyle,
              ),
              Checkbox(
                value: _status.pickTop,
                onChanged: (value) {},
              ),
              Expanded(
                flex: 2,
                child: Text(''),
              ),
              Text(
                '冰箱门关闭:',
                style: textStyle,
              ),
              Checkbox(
                value: _status.fridgeClose,
                onChanged: (value) {},
              ),
              Expanded(
                child: Text(''),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(''),
              ),
              Text(
                '冰箱门打开:',
                style: textStyle,
              ),
              Checkbox(
                value: _status.fridgeOpen,
                onChanged: (value) {},
              ),
              Expanded(
                flex: 2,
                child: Text(''),
              ),
              Text(
                '冰箱温度:${_status.tempValue}℃',
                style: tempValueTextStyle,
              ),
              Expanded(
                child: Text(''),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '冰箱门测试',
            style: TextStyle(
              fontSize: 30,
              color: Colors.deepOrange,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '电机速度:',
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
                Expanded(
                  child: CupertinoTextField(
                    textAlign: TextAlign.center,
                    placeholder: '请输入冰箱门电机速度',
                    clearButtonMode: OverlayVisibilityMode.editing,
                    keyboardType: TextInputType.number,
                    controller: fridgeController,
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
                child: textButtonCreate(_onClickCloseFridge, '关闭冰箱门',
                    EdgeInsets.fromLTRB(20, 0, 20, 0)),
              ),
              Expanded(
                child: textButtonCreate(_onClickOpenFridge, '打开冰箱门',
                    EdgeInsets.fromLTRB(20, 0, 20, 0)),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '升降电机测试',
            style: TextStyle(
              fontSize: 30,
              color: Colors.deepOrange,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '电机速度:',
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
                Expanded(
                  child: TextField(
                    controller: pickSpController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '请输入升降电机速度',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '脉冲个数:',
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
                Expanded(
                  child: TextField(
                    controller: pickStepController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '请输入升降电机脉冲个数',
                    ),
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
                child: textButtonCreate(
                    _onClickDownPick, '下降', EdgeInsets.fromLTRB(20, 0, 20, 0)),
              ),
              Expanded(
                child: textButtonCreate(
                    _onClickUpPick, '上升', EdgeInsets.fromLTRB(20, 0, 20, 0)),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '其他测试',
            style: TextStyle(
              fontSize: 30,
              color: Colors.deepOrange,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: textButtonCreate(_onClickCloseCompressor, '关闭空压机',
                    EdgeInsets.fromLTRB(10, 0, 10, 0)),
              ),
              Expanded(
                child: textButtonCreate(_onClickOpenCompressor, '打开空压机',
                    EdgeInsets.fromLTRB(10, 0, 10, 0)),
              ),
              Expanded(
                child: textButtonCreate(_onClickOpenELock, '打开电磁锁',
                    EdgeInsets.fromLTRB(10, 0, 10, 0)),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(""),
              ),
              Expanded(
                flex: 2,
                child: textButtonCreate(
                    _onClickInit, '初始化', EdgeInsets.fromLTRB(0, 0, 0, 10)),
              ),
              Expanded(
                child: Text(""),
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
    print('Test Page 初始化');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Test Page 消除');
  }
}
