import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/flutter_flow/custom_functions.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

List<String> fileManagerBreadcrumb(String? parentpath) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (parentpath == null || parentpath.isEmpty) {
    return [''];
  }

  // Remove the last string and then split by '/'
  List<String> pathList = parentpath.split('/');

  // Remove the index with the exact word 'home'
  pathList.removeWhere((element) => element == 'home');

  // Append '/' to each index
  for (int i = 0; i < pathList.length; i++) {
    pathList[i] = pathList[i] + '/';
  }

  // Remove the last index if it contains only '/'
  if (pathList.isNotEmpty && pathList.last == '/') {
    pathList.removeLast();
  }

  return pathList;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
