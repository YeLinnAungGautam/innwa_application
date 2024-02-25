import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/screen/order/order.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  List<String> fruits = ['Computer', 'Printer', 'Fans', 'Laptops'];
  List<String> brands = ['Xiaomi', 'Samsung', 'Apple', 'MSI'];
  List<String> electronic = ['Core i7', 'Core i9', 'Core i5', 'Core i3'];
  List<String> selectedFruits = [];
  List<String> selectedBrand = [];
  List<String> selectedElectronic = [];
  final List<String> items = [
    'Ayeyarwady',
    'Bago',
    'Chin',
    'Kachin',
    'Kayah',
    'Kayin',
    'Magway',
    'Mandalay',
    'Mon',
    'Naypyitaw',
    'Rakhine',
    'Sagaing',
    'Shan',
    'Tanintharyi',
    'Yangon'
  ];
  final List<String> townShip = [
    'Ahlon',
    'Bahan',
    'Botataung',
    'Dagon Seikkan ',
    'Dagon',
    'Dala ',
    'Dawbon',
    'East Dagon',
    'Hlaing',
    'Hlaingthaya ',
    'Insein',
    'Kamayut',
    'Kyauktada',
    'Kyimyindaing',
    'Lanmadaw'
  ];
  String? selectedValue;
  String? selectedTownshipValue;
  bool onFocus = false;
  final FocusScopeNode _node = FocusScopeNode();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          drawer: CustomDrawerWidget(onDrawerTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
              currentFocus.unfocus();
            }
          }),
          appBar: TopBar(
            needBackButton: true,
            needMenu: false,
            title: "Deliver Address",
          ),
          body: Column(
            children: [
              Expanded(
                
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 10.0),
                              child: RobotoText(
                                  fontSize: 16.0,
                                  fontColor: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  text: "Please fill following information"),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CustomTextFormField(
                            needBackground: true,
                            label: "Name",
                            onSaved: () => {},
                            pass: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CustomTextFormField(
                            needBackground: true,
                            label: "Phone",
                            onSaved: () => {},
                            pass: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CustomTextFormField(
                            needBackground: true,
                            label: "Email",
                            onSaved: () => {},
                            pass: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Region/Division',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select Region/Division';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 60,
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'City',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select City';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 60,
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Township',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: townShip
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select Township';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              selectedTownshipValue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 60,
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CustomTextFormField(
                            needBackground: true,
                            label: "Address",
                            onSaved: () => {},
                            pass: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CustomTextFormField(
                            needBackground: true,
                            label: "Addition Note",
                            onSaved: () => {},
                            pass: false,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,bottom: 10.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Order())),
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      child: Center(
                          child: Text(
                        'Next',
                        style: GoogleFonts.roboto(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
