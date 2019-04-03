class DeviceStatus {
  final bool compressor;
  final bool doorClose;
  final bool pickTop;
  final bool fridgeClose;
  final bool fridgeOpen;
  final double tempValue;
  final int position1;
  final int position2;

  DeviceStatus.normal({
    this.compressor = false,
    this.doorClose = false,
    this.pickTop = false,
    this.fridgeOpen = false,
    this.fridgeClose = false,
    this.tempValue = 0,
    this.position1 = 0,
    this.position2 = 0,
  });

  DeviceStatus({
    this.compressor,
    this.doorClose,
    this.pickTop,
    this.fridgeClose,
    this.fridgeOpen,
    this.tempValue,
    this.position1,
    this.position2,
  });
}
