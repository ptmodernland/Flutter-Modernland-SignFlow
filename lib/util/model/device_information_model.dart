class DeviceInformationModel {
  final String deviceType;
  final String model;
  final String brand;
  final String ipAddress;
  final String deviceInfoString;

  DeviceInformationModel({
    required this.deviceType,
    required this.model,
    required this.brand,
    required this.ipAddress,
  }) : deviceInfoString = _generateDeviceInfoString(deviceType, model, brand, ipAddress);

  static String _generateDeviceInfoString(String deviceType, String model, String brand, String ipAddress) {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln('Device Type: $deviceType');
    buffer.writeln('Model: $model');
    buffer.writeln('Brand: $brand');
    buffer.writeln('IP Address: $ipAddress');
    return buffer.toString();
  }
}