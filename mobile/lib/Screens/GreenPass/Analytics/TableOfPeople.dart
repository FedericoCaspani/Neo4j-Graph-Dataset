import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Payload/API/Maps/Serializable/Q1.dart' as placeNames;


import '../../../constraints.dart';

class TableOfPeople extends StatefulWidget {
  @override
  _TableState createState() => _TableState();
}

class _TableState extends State<TableOfPeople> {

  final TextEditingController _textController = new TextEditingController();
  List<DataRow> dataRows = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kPrimaryLightColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tax code'
              ),
              controller: _textController,
              onSubmitted: (String value) => apiCall(value),
            ),
            SizedBox(height: 30,),
            DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Surname')),
                DataColumn(label: Text('TaxCode'))
              ],
              rows: dataRows,
            )
          ],
        ),
      ),
    );
  }
  
  Future apiCall(String place) async {
    try {
      var response = await placeNames.placeQuarantinedPeople(place);
      for (final value in response.persons) {
        dataRows.add(DataRow(cells: [DataCell(Text(value.name)), DataCell(Text(value.surname)), DataCell(Text(value.taxCode))]));
      }
    } catch (e) {
      print(e);
    }
  }
}