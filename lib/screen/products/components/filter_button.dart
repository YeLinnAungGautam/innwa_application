import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/filter/filter.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  var computerItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String dropdownvalue = 'Item 1';
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Filter By'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  DropdwonButtonOne(),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: () =>  Scaffold.of(context).openEndDrawer(),
      // onTap: () => Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const FilterBy())
      //     ),
      child: Container(
        width: 320,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: 0,
              blurRadius: 6,
              color: Color.fromRGBO(200, 199, 199, 1),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.filter_alt_sharp), Text('Filter By')],
        )),
      ),
    );
  }

  Widget DropdwonButtonOne() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.grey, //background color of dropdown button
          border: Border.all(
              color: Colors.black38, width: 3), //border of dropdown button
          borderRadius:
              BorderRadius.circular(10), //border raiuds of dropdown button
          boxShadow: const <BoxShadow>[
            //apply shadow on Dropdown button
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 1) //blur radius of shadow
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: DropdownButton(
          // Initial Value
          value: dropdownvalue,
          isExpanded: true, //make true to take width of parent widget
          underline: Container(),

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: computerItems.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        ),
      ),
    );
  }
}
