import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/filter/filter.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:multiselect/multiselect.dart';

class PromotionFilterButton extends StatefulWidget {
  const PromotionFilterButton({super.key});

  @override
  State<PromotionFilterButton> createState() => _PromotionFilterButtonState();
}

class _PromotionFilterButtonState extends State<PromotionFilterButton> {

  List<String> fruits = ['Computer', 'Printer', 'Fans', 'Laptops'];
  List<String> brands = ['Xiaomi', 'Samsung', 'Apple', 'MSI'];
  List<String> electronic = ['Core i7', 'Core i9', 'Core i5', 'Core i3'];
  List<String> selectedFruits = [];
  List<String> selectedBrand = [];
  List<String> selectedElectronic = [];

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Filter By'),
        content: SingleChildScrollView(
          child: ListBody(
            children: listWidget().toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

List<Widget> listWidget(){
  return [
    Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownMultiSelect(
                  options: fruits,
                  selectedValues: selectedFruits,
                  onChanged: (value) {
                    print('selected fruit $value');
                    setState(() {
                      selectedFruits = value;
                    });
                   
                  },
                  whenEmpty: 'Electornics',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownMultiSelect(
                  options: brands,
                  selectedValues: selectedBrand,
                  onChanged: (value) {
                    
                    setState(() {
                      selectedBrand = value;
                    });
                    
                  },
                  whenEmpty: 'Brands',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownMultiSelect(
                  options: electronic,
                  selectedValues: selectedElectronic,
                  onChanged: (value) {
                   
                    setState(() {
                      selectedElectronic = value;
                    });
                    
                  },
                  whenEmpty: 'CPUs',
                ),
              ),
              GestureDetector(
                onTap: () => {},
                child: Container(
                  width: 320,
                  height: 50,
                  decoration: BoxDecoration(
                   
                    borderRadius: BorderRadius.circular(10),
                    color: bottomSheetColor2,
                  ),
                  child: const Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_alt_sharp,color: Colors.white,),
                      Text('Filter',style: TextStyle(color: Colors.white),)
                    ],
                  )),
                ),
              )
  ];
}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FilterBy())),
      child: Container(
        width: 150,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
          BoxShadow(
            offset: Offset(3, 3),
            spreadRadius: -3,
            blurRadius: 5,
            color: Color.fromRGBO(191, 191, 191, 1),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.filter_alt,color: Colors.indigo,size: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "Filter By"),                
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
