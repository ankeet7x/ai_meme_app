import 'dart:typed_data';
import 'dart:convert';

Uint8List getBytesFromBase64(String base64Image) {
  return base64Decode(base64Image);
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
