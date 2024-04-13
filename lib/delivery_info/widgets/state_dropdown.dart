import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/delivery_info/bloc/delivery_info_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class StateDropDown extends StatelessWidget {
  const StateDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryInfoBloc, DeliveryInfoState>(
      builder: (context, state) {
        final DeliveryInfoBloc deliveryInfoBloc = BlocProvider.of(context);
        return state.stateGetState == ApiStatus.completed
            ? LocalizationWidget(
                en: 'Please Select State',
                mm: 'ပြည်နယ်ကို ရွေးပါ',
                child: (val) {
                  return BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField2(
                          value: cartState.selectedState?.id.toString(),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          isExpanded: true,
                          hint: LocalizationWidget(
                              en: "State",
                              mm: "ပြည်နယ်",
                              child: (val) {
                                return Text(
                                  val,
                                  style: const TextStyle(fontSize: 14),
                                );
                              }),
                          items: state.states
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e.id.toString(),
                                  child: LocalizationWidget(
                                      en: e.enName,
                                      mm: e.mmName,
                                      child: (val) {
                                        return RobotoText(
                                          fontSize: 15,
                                          fontColor: null,
                                          text: val,
                                          fontWeight: FontWeight.w600,
                                        );
                                      }),
                                ),
                              )
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return val;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              final selectedState = state.states
                                  .where((element) =>
                                      element.id.toString() == value)
                                  .first;
                              deliveryInfoBloc.add(UpdateSelectedStateEvent(
                                  context: context, data: selectedState));
                            }
                            //Do something when changing the item if you want.
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
                      );
                    },
                  );
                })
            : state.stateGetState == ApiStatus.processing
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        maximumSize: const Size.fromHeight(70),
                      ),
                      onPressed: () {
                        deliveryInfoBloc.add(GetStateEvent(context: context));
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.refresh,
                            size: 15,
                          ),
                          5.horizontal,
                          RobotoText(
                            fontSize: 14,
                            fontColor: null,
                            text: "Retry",
                          ),
                        ],
                      ),
                    ),
                  );
      },
    );
  }
}
