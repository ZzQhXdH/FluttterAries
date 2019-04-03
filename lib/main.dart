import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chart/BLEManager.dart';
import 'main/BLE.dart';

void main() => runApp(ScanPage());

class ScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MainScanPage(),
    );
  }
}

class _MainScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScanState();
}

class _MainScanState extends State<_MainScanPage> {

  Widget _buildListView() => ListView.builder(
        itemBuilder: (context, index) => _buildItem(index),
        itemCount: BLEManager.instance.devices.length,
      );

  Widget _buildItem(int index) {
    final dev = BLEManager.instance.devices[index];
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
          child: InkWell(
        onTap: () => _onTapConnect(dev),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(CupertinoIcons.bluetooth),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '名称: ${dev.device.name}',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '信号强度: ${dev.rssi}dB',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void _onTapConnect(BLEDevice dev) {
    BLEManager.instance.selectDev = dev;
    Navigator.push(context, CupertinoPageRoute(
      builder: (context) {
        return BLE();
      },
    ));
  }

  void _onPressedScan() {
    _startScan();
    _showScanWaitDialog();
  }

  void _onScanCancel() {
    BLEManager.instance.stopScan();
  }

  void _startScan() {
    BLEManager.instance.devices.clear();
    setState(() {});
    BLEManager.instance.startScan((ret) {
      setState(() {});
    });
  }

  void _showScanWaitDialog() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('正在扫描'),
            content: CupertinoActivityIndicator(
              radius: 20,
            ),
            actions: <Widget>[
              CupertinoButton(
                child: Text('停止'),
                onPressed: () {
                  Navigator.pop(context);
                  _onScanCancel();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('白羊座调试助手'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: _buildListView(),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: CupertinoButton.filled(
                  child: Text('扫描设备'),
                  onPressed: _onPressedScan,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    print('Main 初始化');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Main 删除');
  }


}
