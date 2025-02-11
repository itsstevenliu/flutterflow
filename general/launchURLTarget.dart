// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:url_launcher/url_launcher.dart'; // Import for url_launcher
import 'package:flutter/foundation.dart'; // Import for kIsWeb

Future launchURLTarget(
  String url,
  String tab, // Note: `tab` parameter will only be used for web
) async {
  if (url.isEmpty) {
    throw ArgumentError('URL cannot be empty.');
  }

  if (kIsWeb && tab == '_self') {
    // Open in the same tab for Web
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
  } else if (kIsWeb && tab != '_self') {
    // Open in a new tab for Web
    await launchUrl(Uri.parse(url), webOnlyWindowName: tab);
  } else {
    // For mobile platforms, open the URL in the default browser
    await launchUrl(Uri.parse(url));
  }
}
