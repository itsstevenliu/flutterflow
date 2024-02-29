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

List<PostsRecord> postFilter(
  List<PostsRecord> allPosts,
  List<DocumentReference> userBlocked,
  List<DocumentReference> userBlockedBy,
  List<DocumentReference> followingList,
  DocumentReference authUser,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  List<PostsRecord> filteredPosts = [];

  for (PostsRecord post in allPosts) {
    // Access the user_id reference based on your PostsRecord class structure
    DocumentReference<Object?>? userReference = post.userRef;

    if (userReference == authUser) {
      filteredPosts.add(post);
    } else if (userBlocked.contains(userReference)) {
      continue; // Skip this post
    } else if (userBlockedBy.contains(userReference)) {
      continue; // Skip this post
    } else if (followingList.contains(userReference)) {
      filteredPosts.add(post); // Add this post to the filtered list
    } else {
      filteredPosts.add(post);
    }
  }

  return filteredPosts;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
