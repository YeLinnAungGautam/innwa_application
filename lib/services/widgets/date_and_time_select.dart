import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/services/bloc/services_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class DateTimeSelect extends StatelessWidget {
  const DateTimeSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        final ServicesBloc servicesBloc =
            BlocProvider.of<ServicesBloc>(context);
        return Column(
          children: [
            Form(
              key: servicesBloc.form,
              child: SizedBox(
                height: 45,
                child: TextFormField(
                  controller: servicesBloc.nameController,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  validator: (val) {
                    if (val != null && val.isEmpty) {
                      return "Please fill the name";
                    }
                    return null;
                  },
                ),
              ),
            ),
            20.vertical,
            GestureDetector(
              onTap: () {
                servicesBloc.add(ShowDatePickerEvent(context: context));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RobotoText(
                      fontSize: 16,
                      fontColor: null,
                      fontWeight: FontWeight.w600,
                      text: state.selectedDate == null
                          ? "Select Date"
                          : state.selectedDate.toString().split(" ")[0],
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            20.vertical,
            GestureDetector(
              onTap: () {
                servicesBloc.add(ShowTimePickerEvent(context: context));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RobotoText(
                      fontSize: 16,
                      fontColor: null,
                      fontWeight: FontWeight.w600,
                      text: state.time == null
                          ? "Select Time"
                          : '${state.time!.hour} : ${state.time!.minute}',
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            20.vertical,
            ElevatedButton(
              onPressed: state.selectedService == null ||
                      state.selectedDate == null ||
                      state.time == null ||
                      state.sendStatus == ApiStatus.processing
                  ? null
                  : () {
                      servicesBloc
                          .add(ClickBookAppointmentEvent(context: context));
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: const Text("Book Appointment"),
            )
          ],
        );
      },
    );
  }
}
