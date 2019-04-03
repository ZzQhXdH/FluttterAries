import 'dart:async';
import 'EventBusManager.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../event/BluetoothConnectedEvent.dart';
import '../event/BluetoothDisconnectedEvent.dart';

class BLEManager {

  final ServerUUID = "0000ffe0-0000-1000-8000-00805f9b34fb";
  final CharaUUID = "0000ffe1-0000-1000-8000-00805f9b34fb";
  final DescrUUID = "00002902-0000-1000-8000-00805f9b34fb";

  static BLEManager _instance;

  static BLEManager get instance => _getInstance();

  static BLEManager _getInstance() {
    if (_instance == null) {
      _instance = BLEManager._internal();
    }
    return _instance;
  }

  StreamSubscription<ScanResult> _scanSubscription;

  List<BLEDevice> devices = List<BLEDevice>();

  BLEDevice selectDev;

  StreamSubscription<BluetoothDeviceState> conn;
  BluetoothCharacteristic chara;

  BLEManager._internal() {}

  void connect() {
    if (conn != null) {
      conn.cancel();
    }
    conn = FlutterBlue.instance.connect(
      selectDev.device,
      timeout: Duration(seconds: 30),
      autoConnect: true,
    ).listen((s) {
      if (s == BluetoothDeviceState.connected) {
        print('蓝牙连接成功');
        _handleConnect();
      } else {
        print('蓝牙连接状态:${s.toString()}');
        EventBusManager.instance.bus.fire(BluetoothDisconnectedEvent());
      }
    });
  }

  void cancel() {
    conn.cancel();
    conn = null;
  }

  void write(List<int> data) async {
    await selectDev.device.writeCharacteristic(chara, data);
  }

  void _handleConnect() async {
    final services = await selectDev.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() != ServerUUID) {
        return;
      }
      final charas = service.characteristics;
      print('服务:${service.uuid.toString()}');
      charas.forEach((chara) {
        if (chara.uuid.toString() != CharaUUID) {
          return;
        }
        this.chara = chara;
        print('属性:${chara.uuid.toString()}');
        final des = chara.descriptors;
        des.forEach((de) {
          if (de.uuid.toString() != DescrUUID) {
            return;
          }
          print('描述:${de.uuid.toString()}');
          _setNotify(chara, de);
        });
      });
    });
  }

  void _setNotify(BluetoothCharacteristic chara, BluetoothDescriptor descriptor) async {
    await selectDev.device.writeDescriptor(descriptor, [0x01, 0x00]);
    await selectDev.device.setNotifyValue(chara, true);
    selectDev.device.onValueChanged(chara).listen((value) {
      print('接收数据:${value}');
    });
    print('蓝牙最终连接成功');
    EventBusManager.instance.bus.fire(BluetoothConnectedEvent());
  }

  void startScan(void onScanResult(BLEDevice device)) {
    _scanSubscription = FlutterBlue.instance.scan().listen((result) {
      final device = result.device;
      if (device == null) {
        return;
      }
      final name = device.name;
      if (name == null || name.isEmpty) {
        return;
      }
      final ble = BLEDevice(device: device, rssi: result.rssi);
      final ret = devices.contains(ble);
      if (!ret) {
        devices.add(ble);
        onScanResult(ble);
      }
    });
  }

  void stopScan() {
    _scanSubscription.cancel();
  }
}

class BLEDevice {
  final BluetoothDevice device;
  final int rssi;

  BLEDevice({this.device, this.rssi});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BLEDevice &&
          runtimeType == other.runtimeType &&
          device.id == other.device.id;

  @override
  int get hashCode => device.hashCode;
}
