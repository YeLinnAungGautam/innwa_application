import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';


class SelectStorage extends StatefulWidget {
  final bool isColor;
  
  SelectStorage({super.key,required this.isColor});

  @override
  State<SelectStorage> createState() => _SelectStorageState();
}

class _SelectStorageState extends State<SelectStorage> {
  bool selected = false;
  int? _selectedValueIndex;
  Color selectedColor = Colors.white;
  List<Color> colors = [Colors.pink,Colors.amber,Colors.black,Colors.red];
  List<String> colorStrings = ["Pink","Gold", "Black","Red"];
  List<String> storages = ["64 GB","128 GB","512 GB","1TB"];
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.05,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                  setState(() {                    
                    _selectedValueIndex = index;
                  });
              },
              child:
              Row(
                children: [

                  Container(
                    width: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                  color: index == _selectedValueIndex ? Colors.blue[400]! : Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(child: RobotoText(fontSize: 15.0, fontWeight: FontWeight.bold, fontColor: index == _selectedValueIndex ? Colors.white : Colors.black, text: storages[index])),
                ),
              )
                 
                ],
              )



            ),
          );
    
        },
      ),
    );
  }
}