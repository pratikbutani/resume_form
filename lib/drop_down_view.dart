import 'package:flutter/material.dart';

class DropDownView extends StatelessWidget {
  final String selectedValue;
  final Function(String) onValueChange;
  final String hintText;
  final List<String> items;

  const DropDownView(
      {Key key,
      this.selectedValue,
      this.onValueChange,
      this.hintText,
      this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        icon: Icon(Icons.corporate_fare_outlined),
        value: selectedValue,
        underline: SizedBox(),
        isExpanded: true,
        focusColor: Theme.of(context).primaryColor,
        iconEnabledColor: Theme.of(context).primaryColor,
        iconDisabledColor: Colors.grey,
        iconSize: 32,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        hint: Text(hintText),
        onChanged: (newValue) {
          onValueChange(newValue);
          /*
          setState(() {
            _selectedProfessionalQualification = newValue;
          });
*/
        },
      ),
    );
  }
}
