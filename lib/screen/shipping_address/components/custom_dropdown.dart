import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class CustomDropDown extends StatefulWidget {
  double width;
  CustomDropDown({super.key, required this.width});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    // Step 1.
    String dropdownValue = 'Yangon';
// Step 2.
    return Container(
      width: widget.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        
        boxShadow: [
        BoxShadow(
          offset: Offset(0, 0),
          spreadRadius: -5,
          blurRadius: 8,
          color: Color.fromRGBO(147, 147, 147, 1),
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: DropdownButton<String>(
        // Step 3.
        value: dropdownValue,
        underline: Container(),        // Step 4.
        items: <String>['Yangon', 'Mandalay', 'Nay Pyi Taw', 'Shan']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(

            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
        // Step 5.
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
      ),
    );
  }
}
