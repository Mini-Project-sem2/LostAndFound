import 'dart:developer';
import 'package:lost_and_found/config.dart' as config show w3v3_api;
import 'package:what3words/what3words.dart';

var w3w3 = What3WordsV3(config.w3v3_api);

w3v3() {
  log(getData().toString());
  return getData();
}

Future<dynamic> getData() async {
  return await w3w3
      .convertTo3wa(Coordinates(18.96558885, 73.10288130582491))
      .language('en')
      .execute();
}
