import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class FilterList extends StatefulWidget {
  const FilterList({super.key});

  @override
  State<FilterList> createState() => FilterListState();
}

class FilterListState extends State<FilterList> {
  List<bool> isExpandedList = List.generate(5, (index) => false);
  Map<String, List> items = {
    'Apple': ["Macbook Air M2", "Macbook Pro M1"],
    'Smartphone': ["Xiaomi", "Samsung", "Realme", "Huawei"],
    'Office Appliance & Network': ["Webcam", "Projector", "CCTV"],
    'Sort By' : ["Default", "Best Selling", "New Arrival"]
    
  };

  String _value = "default";
  String _sortValue = "default";

  void updateText(String newText) {
     setState(() {
      _sortValue = newText;
      _value = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final String itemKey = items.keys.elementAt(index);
          final List<dynamic> itemValues = items[itemKey]!;
          return Wrap(
            children: [
              ExpansionTile(
                collapsedShape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                title: RobotoText(fontSize: 17.0, fontColor: Colors.black, text: items.keys.elementAt(index)),
                onExpansionChanged: (value) {
                  setState(() {
                    isExpandedList[index] = value;
                  });
                },
                initiallyExpanded: isExpandedList[index],
                children: [
                  ...itemValues.map((value) => Padding(
                        padding: const EdgeInsets.only(left :16.0, right: 16.0,top: 8.0),
                        child: InkWell(
                          onTap: () {
                            setState((){
                                      if(itemKey == "Sort By")
                                      {
                                        _sortValue = value;
                                      }
                                      else{
                                        _value = value;
                                      }
                          });},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RobotoText(fontSize: 15.0, fontColor: Colors.black, text: value),
                                Radio(
                                  onChanged: (paramValue) {
                                    setState(() {
                                      if(itemKey == "Sort By")
                                      {
                                        _sortValue = paramValue;
                                      }
                                      else{
                                        _value = paramValue!;
                                      }
                                      
                                    });
                                  },
                                  value: value,
                                  groupValue: itemKey=="Sort By"? _sortValue : _value,
                                )
                              ]),
                        ),
                      ),
                      
                      ),
                     
                ],
              ),
              
              Divider(height: 1, color: Colors.grey[300],)
            ],
          );
        });
  }
}
