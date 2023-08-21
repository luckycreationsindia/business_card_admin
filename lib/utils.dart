import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:nfc_host_card_emulation/nfc_host_card_emulation.dart' as nfc_emulator;

class Utils extends ChangeNotifier {
  Future<void> writeToNFCTag(String url, ValueNotifier<dynamic> result) async {
    if(kIsWeb) return Future.error("NFC Not Supported");
    var availability = await FlutterNfcKit.nfcAvailability;
    if(availability != NFCAvailability.available) return Future.error("NFC Not Supported");

    var tag = await FlutterNfcKit.poll(timeout: const Duration(seconds: 10),
        iosMultipleTagMessage: "Multiple tags found!", iosAlertMessage: "Scan your tag");

    if (kDebugMode) print(jsonEncode(tag));

    bool isWritable = tag.ndefWritable ?? false;
    if(!isWritable) return Future.error("NFC Tag is not writable");

    await FlutterNfcKit.writeNDEFRawRecords([NDEFRawRecord("", "", "", ndef.TypeNameFormat.empty)]);
    await FlutterNfcKit.writeNDEFRecords([ndef.UriRecord.fromString(url)]);
    await FlutterNfcKit.finish();

    result.value = "Success";
    result.notifyListeners();
    return Future.value();
  }

  Future<void> _emulate() async {
    final nfcState = await nfc_emulator.NfcHce.checkDeviceNfcState();

    if(nfcState != nfc_emulator.NfcState.enabled) return Future.error("NFC Emulation Not Supported");

    nfc_emulator.NfcHce.stream.listen((command) {
      if (kDebugMode) {
        print(command);
      }
    });

    await nfc_emulator.NfcHce.init(
      aid: Uint8List.fromList([0xA0, 0x00, 0xDA, 0xDA, 0xDA, 0xDA, 0xDA]),
      permanentApduResponses: true,
      listenOnlyConfiguredPorts: false,
    );
  }
}