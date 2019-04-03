import 'package:flutter/material.dart';
import 'page/SettingPage.dart';
import 'page/RobotArmPage.dart';
import 'page/TestPage.dart';
import '../chart/BLEManager.dart';
import '../event/BluetoothConnectedEvent.dart';
import '../event/BluetoothDisconnectedEvent.dart';
import '../chart/EventBusManager.dart';
import 'package:flutter/cupertino.dart';

class BLE extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BLEState();
  }
}

class BLEState extends State<BLE> with SingleTickerProviderStateMixin {
  PageController _controller;
  int _index = 0;

  void _onBluetoothConnectedEvent(BluetoothConnectedEvent env) {
    print('蓝牙已经连接成功');
    setState(() {
      isConnected = true;
    });
  //  Navigator.pop(context);
  }

  void onBluetoothDisconnectedEvent(BluetoothDisconnectedEvent env) {
    print('蓝牙已经断开连接');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController();
    print('BLE 初始化');
    EventBusManager.instance.create();
    EventBusManager.instance.bus.on<BluetoothConnectedEvent>().listen(_onBluetoothConnectedEvent);
    EventBusManager.instance.bus.on<BluetoothDisconnectedEvent>().listen(onBluetoothDisconnectedEvent);
    BLEManager.instance.connect();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    print('BLE 消除');
    BLEManager.instance.cancel();
    EventBusManager.instance.bus.destroy();
  }

  final progress = Scaffold(
    body: Center(
      child: CupertinoActivityIndicator(radius: 40,),
    ),
  );

  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !isConnected ? progress : GestureDetector(
      onTapDown: (d) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: PageView(
          onPageChanged: (index) {
            if (_index == index) {
              return;
            }
            setState(() {
              _index = index;
            });
          },
          controller: _controller,
          children: <Widget>[
            TestPage(),
            RobotArmPage(),
            SettingPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (index) {
            if (_index == index) {
              return;
            }
            setState(() {
              _controller.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/ic_test.png',
                  scale: 10,
                ),
                title: Text('测试')),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_robot_arm.png',
                scale: 10,
              ),
              title: Text('机械臂'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_setting.png',
                scale: 10,
              ),
              title: Text('设置'),
            ),
          ],
        ),
      ),
    );
  }
}
