import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/delivery_info/bloc/delivery_info_bloc.dart';
import 'package:innwa_mobile_dev/delivery_info/widgets/state_dropdown.dart';
import 'package:innwa_mobile_dev/delivery_info/widgets/township_dropdown.dart';
import 'package:innwa_mobile_dev/screen/order/order.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class DeliveryInfoScreen extends StatefulWidget {
  const DeliveryInfoScreen({super.key});

  @override
  State<DeliveryInfoScreen> createState() => _DeliveryInfoScreenState();
}

class _DeliveryInfoScreenState extends State<DeliveryInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeliveryInfoBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final DeliveryInfoBloc deliveryInfoBloc =
            BlocProvider.of<DeliveryInfoBloc>(context)
              ..add(GetStateEvent(context: context));
        return LocalizationWidget(
            en: "Deliver Address",
            mm: "ပေးပို့ရန်လိပ်စာ",
            child: (deliAddress) {
              return Container(
                color: backgroundColorLight,
                child: SafeArea(
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.white,
                    drawer: CustomDrawerWidget(onDrawerTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.hasFocus) {
                        currentFocus.unfocus();
                      }
                    }),
                    appBar: TopBar(
                      needBackButton: true,
                      needMenu: false,
                      showCart: false,
                      title: deliAddress,
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
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 10.0),
                                        child: RobotoText(
                                            fontSize: 16.0,
                                            fontColor: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            text:
                                                "Please fill following information"),
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
                                  const StateDropDown(),
                                  BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      return state.selectedState != null
                                          ? const TownshipDropDown()
                                          : const SizedBox();
                                    },
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
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 10.0),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Order())),
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
            });
      }),
    );
  }
}
