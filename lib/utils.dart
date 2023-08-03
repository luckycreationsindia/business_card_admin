import 'dart:convert';

import 'package:business_card_admin/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

class Utils {
  Future<bool> writeToNFCTag(String id) async {
    if(kIsWeb) return Future.value(false);
    NFCAvailability availability = await FlutterNfcKit.nfcAvailability;
    if(availability != NFCAvailability.available) return Future.value(false);

    var tag = await FlutterNfcKit.poll(timeout: const Duration(seconds: 10),
        iosMultipleTagMessage: "Multiple tags found!", iosAlertMessage: "Scan your tag");

    print(jsonEncode(tag));

    bool isWritable = tag.ndefWritable ?? false;
    if(!isWritable) return Future.value(false);

    await FlutterNfcKit.writeNDEFRawRecords([NDEFRawRecord("", "", "", ndef.TypeNameFormat.empty)]);
    await FlutterNfcKit.writeNDEFRecords([ndef.UriRecord.fromString("${Consts.env["WEB_ROOT"] ?? "http://localhost/"}?id=$id")]);

    await FlutterNfcKit.finish();

    return Future.value(false);
  }
}