import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';


class SelectColors extends StatefulWidget {
  final bool isColor;
  
  SelectColors({super.key,required this.isColor});

  @override
  State<SelectColors> createState() => _SelectColorsState();
}

class _SelectColorsState extends State<SelectColors> {
  bool selected = false;
  int? _selectedValueIndex;
  Color selectedColor = Colors.white;
  List<Color> colors = [Colors.pink,Colors.amber,Colors.black,Colors.red];
  List<String> colorStrings = ["Pink","Gold", "Black","Red"];
  List<String> storages = ["64 GB","128 GB","512 GB","1TB"];
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      height: 40,
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
                  
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: colors[index],
                                border: Border.all(width: 3, color: index == _selectedValueIndex ? Colors.black : Colors.white,strokeAlign: BorderSide.strokeAlignInside)),
                            child: Container(
                  
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: colors[index],
                                border: Border.all(width: 3, color: Colors.white,strokeAlign: BorderSide.strokeAlignInside)),
                            
                          ),
                          ),
                  Padding(
                    padding: const EdgeInsets.only(left : 3.0),
                    child: Text(colorStrings[index].toLowerCase(),style: TextStyle(fontWeight: FontWeight.bold),),
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