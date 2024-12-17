import 'dart:convert';

class StrEncoding {
  StrEncoding._();

  static final StrEncoding I = StrEncoding._();

  String dataUri(String htmlContent) {
    return Uri.dataFromString(
      htmlContent,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
  }
}
