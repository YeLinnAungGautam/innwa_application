import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/filter/filter_list.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({super.key});

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  Map<String, List> items = {
    'Electronics': ["Computer", "Mobile"],
    'HouseHold': ["Computer", "Mobile"],
  };

  String selectedOption = '';
  String radioValue = "defult";

  final GlobalKey<FilterListState> _childKey = GlobalKey<FilterListState>();

  void updateChildText() {
    _childKey.currentState?.updateText("default");
  }

  void setSelectedOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  String dropdownvalue = 'Electronics';
  List<String> fruits = ['Computer', 'Printer', 'Fans', 'Laptops'];
  List<String> brands = ['Xiaomi', 'Samsung', 'Apple', 'MSI'];
  List<String> electronic = ['Core i7', 'Core i9', 'Core i5', 'Core i3'];
  List<String> selectedFruits = [];
  List<String> selectedBrand = [];
  List<String> selectedElectronic = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RobotoText(
                                fontSize: 20.0,
                                fontColor: Colors.black,
                                text: "Filter By",
                                fontWeight: FontWeight.normal),
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      updateChildText();
                                    },
                                    child: RobotoText(
                                        fontSize: 15.0,
                                        fontColor: Colors.blue,
                                        text: "Clear"),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () =>
                                          Scaffold.of(context).closeEndDrawer(),
                                      child: const Icon(
                                        Icons.close,
                                        size: 25,
                                      )))
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: FilterList(
                          key: _childKey,
                        )),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: RobotoText(
                    //           fontSize: 20.0,
                    //           fontColor: Colors.black,
                    //           text: "Sort By",
                    //           fontWeight: FontWeight.normal),
                    //     ),
                    //   ],
                    // ),
                    // RadioListTile(
                    //   title: Text('Default'),
                    //   value: 'defalult',
                    //   groupValue: selectedOption,
                    //   onChanged: (value) {
                    //     setSelectedOption(value!);
                    //   },
                    // ),
                    // RadioListTile(
                    //   title: Text('Most Popular'),
                    //   value: 'most_popular',
                    //   groupValue: selectedOption,
                    //   onChanged: (value) {
                    //     setSelectedOption(value!);
                    //   },
                    // ),
                    // RadioListTile(
                    //   title: Text('Best Selling'),
                    //   value: 'best_selling',
                    //   groupValue: selectedOption,
                    //   onChanged: (value) {
                    //     setSelectedOption(value!);
                    //   },
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Container(
                      width: 280,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: bottomSheetColor2,
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RobotoText(
                            fontSize: 18.0,
                            fontColor: Colors.white,
                            text: "Apply",
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
