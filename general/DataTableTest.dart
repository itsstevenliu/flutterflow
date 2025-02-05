// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class DataTableTest extends StatefulWidget {
  const DataTableTest({
    super.key,
    this.width,
    this.height,
    required this.inputText,
  });

  final double? width;
  final double? height;
  final List<String> inputText;

  @override
  State<DataTableTest> createState() => _DataTableTestState();
}

class _DataTableTestState extends State<DataTableTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 400,
      child: DataTable(
        columnSpacing: 12,
        horizontalMargin: 12,
        border: TableBorder(
          horizontalInside: BorderSide(width: 1, color: Colors.grey),
          verticalInside: BorderSide(width: 1, color: Colors.grey),
          top: BorderSide(width: 1, color: Colors.grey),
          bottom: BorderSide(width: 1, color: Colors.grey),
          left: BorderSide(width: 1, color: Colors.grey),
          right: BorderSide(width: 1, color: Colors.grey),
        ),
        columns: [
          DataColumn(label: Text('#')),
          DataColumn(label: Text('Input Text')),
          ...List.generate(7, (index) => DataColumn(label: Text(''))),
        ],
        rows: widget.inputText.asMap().entries.map((entry) {
          int rowIndex = entry.key + 1;
          String rowText = entry.value;
          return DataRow(cells: [
            DataCell(Text(rowIndex.toString())),
            DataCell(Text(rowText)),
            ...List.generate(7, (index) => DataCell(Text(''))),
          ]);
        }).toList(),
      ),
    );
  }
}
