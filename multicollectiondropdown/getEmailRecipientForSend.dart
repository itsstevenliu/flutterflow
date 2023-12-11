// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<String>> getEmailRecipientForSend(
    List<DropdownRecipientsStruct> selectedRecipients) async {
  // Add your function code here!

  List<String> emailRecipientsList = [];

// BIG LOOP CHECKING EACH SELECTED RECIPIENT
  for (DropdownRecipientsStruct recipient in selectedRecipients) {
// start checking each row.

// FOR EACH SPECIFIC RECIPIENT...obtain their email address
    if (!recipient.value.contains("distributionList") &&
        !recipient.value.contains("memberTypes") &&
        !recipient.value.contains("all_members")) {
      DocumentReference memberReference =
          FirebaseFirestore.instance.doc(recipient.value);
      DocumentSnapshot memberProfileSnapshot = await memberReference.get();

      if (memberProfileSnapshot.exists) {
        emailRecipientsList.add(memberProfileSnapshot['email']);
      }
    }

    // END

    // if selectedRecipient's value contain "all_members", do a query collection for all members
    if (recipient.value.contains("all_members")) {
      QuerySnapshot memberProfilesSnapshot =
          await FirebaseFirestore.instance.collection('members').get();

      List<MembersRecord> memberProfileList = memberProfilesSnapshot.docs
          .map((doc) => MembersRecord.fromSnapshot(doc))
          .toList();

      // return distributionList
      for (var m in memberProfileList) {
        emailRecipientsList.add('${m.email}');
      }
    }
    // END IF

    // GET ALL MEMBER TYPE BASED ON SELECTION
    if (recipient.label.contains("Member Type")) {
      QuerySnapshot memberProfilesSnapshot = await FirebaseFirestore.instance
          .collection('members')
          .where('memberTypeRef',
              isEqualTo: FirebaseFirestore.instance.doc(recipient.value))
          .get();

      List<MembersRecord> memberProfileList = memberProfilesSnapshot.docs
          .map((doc) => MembersRecord.fromSnapshot(doc))
          .toList();

      // return distributionList
      for (var m in memberProfileList) {
        emailRecipientsList.add('${m.email}');
      }
    }
    // END IF

    // // GET DISTRIBUTION LIST MEMBERS

    if (recipient.label.contains("Distribution List")) {
      DocumentReference distReference =
          FirebaseFirestore.instance.doc(recipient.value);
      DocumentSnapshot distributionSnapshot = await distReference.get();

      if (distributionSnapshot.exists) {
        List<DocumentReference> memberProfilesReferences =
            (distributionSnapshot['members'] as List<dynamic>)
                .map((ref) => ref as DocumentReference)
                .toList();

        for (var memberProfileReference in memberProfilesReferences) {
          DocumentReference memberReference = memberProfileReference;
          DocumentSnapshot memberProfileSnapshot = await memberReference.get();

          if (memberProfileSnapshot.exists) {
            emailRecipientsList.add(memberProfileSnapshot['email']);
          }
        }
      }
    }
  }

  // DEDUPLICATION

  final Set<String> uniqueRecipients = {};

  for (final recipient in emailRecipientsList) {
    uniqueRecipients.add(recipient);
  }

// return unique recipient so one person doesn't get 2 or more emails
  return uniqueRecipients.toList();
}
