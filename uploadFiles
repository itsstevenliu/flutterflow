// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

// THIS CODE ALLOWS CUSTOM FIREBASE PATH AND MAINTAINS THE ORIGINAL NAME OF THE FILE + UID SO SAME NAMED FILES ARE NOT OVERWRITTEN

Future<List<String>?> uploadFilesFINAL(String orgid) async {
  final files = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.any,
  );
  // Declare a list of string to receive fileNames
  List<String> names = [];

  if (files != null) {
    final uploadTasks = files.files.map((file) async {
      print('Selected file: ${file.name}');
      final storage = FirebaseStorage.instance;
      final uuid = Uuid().v1();
      final ref =
      // firebase custom path based on argument orgid
          storage.ref('organizations/$orgid/').child('$uuid-${file.name}');

      int retries = 3;
      String? url;

      while (retries > 0 && url == null) {
        try {
          final task = ref.putData(file.bytes ?? Uint8List(0));
          final snapshot = await task.whenComplete(() {});
          url = await snapshot.ref.getDownloadURL();
          print('File uploaded to $url');

          // put file names in list of string
          names.add(file.name);
        } catch (e) {
          retries -= 1;
          print('Error uploading file: $e. Retries left: $retries');
        }
      }

      return url;
    }).toList();

    // set app state UploadedFileNames to the list of string containing fileNames
    FFAppState().update(() {
      FFAppState().uploadedFileNames = names;
    });

    // if (files != null) {
    //   for (FilePickerResult file in files){

    //   }
    // }

    final List<String?> results = await Future.wait(uploadTasks);
    return results.where((url) => url != null).cast<String>().toList();
  } else {
    // User canceled the file picker dialog
    return null;
  }
}
