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

List<String> availablePathToMoveFile(
  List<String> parentPath,
  List<String> currentFolderName,
  String currentParentPath,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  List<String> combinedList = [];

  for (int i = 0; i < parentPath.length && i < currentFolderName.length; i++) {
    String combinedString = '${parentPath[i]}${currentFolderName[i]}/';
    combinedList.add(combinedString);
  }
  combinedList.add('home/');

  Set<String> uniqueSet = Set<String>.from(combinedList);
  List<String> uniqueCombinedList = uniqueSet.toList();

  // Remove currentParentPath from uniqueCombinedList
  uniqueCombinedList.remove(currentParentPath);

  return uniqueCombinedList;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
