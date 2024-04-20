import 'dart:convert';
import 'dart:io';

void main() {
  var path = 'data.csv';
  new File(path)
    .openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter())
    .forEach((l) => print('line: $l'));
}