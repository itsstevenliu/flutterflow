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

Future<List<DropdownRecipientsStruct>> getDropdownRecipient() async {
  // Add your function code here!

  List<DropdownRecipientsStruct> dropdownRecipientsList = [];

  // ADD reference to ALL members
  DropdownRecipientsStruct dropdownRecipient =
      DropdownRecipientsStruct(label: 'All Members', value: 'all_members');

  dropdownRecipientsList.add(dropdownRecipient);

  // return memberTypes
  QuerySnapshot memberTypeSnapshot =
      await FirebaseFirestore.instance.collection('memberTypes').get();

  List<MemberTypesRecord> memberTypes = memberTypeSnapshot.docs
      .map((doc) => MemberTypesRecord.fromSnapshot(doc))
      .toList();

  for (var m in memberTypes) {
    DropdownRecipientsStruct dropdownRecipient = DropdownRecipientsStruct(
        label: 'Member Type: ${m.name.toString()}',
        value: m.reference.path.toString());

    dropdownRecipientsList.add(dropdownRecipient);
    // dropdownName.add(m.reference.path.toString());
  }

  // return distirbutionList

  QuerySnapshot distributionListSnapshot =
      await FirebaseFirestore.instance.collection('distributionList').get();

  List<DistributionListRecord> distributionList = distributionListSnapshot.docs
      .map((doc) => DistributionListRecord.fromSnapshot(doc))
      .toList();

  // return distributionList
  for (var m in distributionList) {
    DropdownRecipientsStruct dropdownRecipient = DropdownRecipientsStruct(
        label: 'Distribution List: ${m.name.toString()}',
        value: m.reference.path.toString());

    dropdownRecipientsList.add(dropdownRecipient);

    // dropdownName.add(m.reference.path.toString());
  }

  // query member_profiles documents

  QuerySnapshot memberProfilesSnapshot =
      await FirebaseFirestore.instance.collection('members').get();

  List<MembersRecord> memberProfileList = memberProfilesSnapshot.docs
      .map((doc) => MembersRecord.fromSnapshot(doc))
      .toList();

  // return distributionList
  for (var m in memberProfileList) {
    DropdownRecipientsStruct dropdownRecipient = DropdownRecipientsStruct(
        label: '${m.firstName} ${m.lastName}',
        value: m.reference.path.toString());

    dropdownRecipientsList.add(dropdownRecipient);

    // dropdownName.add(m.reference.path.toString());
  }

  return dropdownRecipientsList;
}
