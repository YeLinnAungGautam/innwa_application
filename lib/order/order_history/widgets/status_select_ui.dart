import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/order/order_history/bloc/order_history_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

import '../../../_application/router_service/router_service.dart';

class StatusSelectUi extends StatelessWidget {
  const StatusSelectUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        final OrderHistoryBloc orderHistoryBloc =
            BlocProvider.of<OrderHistoryBloc>(context);
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: LocalizationWidget(
                  en: "Select Status",
                  mm: "အခြေအနေကိုရွေးပါ",
                  child: (val) {
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            RouterService.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                          iconSize: 18.0,
                        ),
                        10.horizontal,
                        RobotoText(
                          fontSize: 20,
                          fontColor: Colors.black,
                          text: val,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderHistoryBloc.orderStatus.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          orderHistoryBloc.add(SelectOrderStatusEvent(
                              context: context,
                              data: orderHistoryBloc.orderStatus[index]));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LocalizationWidget(
                                  en: orderHistoryBloc.orderStatus[index]
                                      ["key"],
                                  mm: orderHistoryBloc.orderStatus[index]
                                      ["mmkey"],
                                  child: (val) {
                                    return RobotoText(
                                      fontSize: 16,
                                      fontColor: null,
                                      text: val,
                                    );
                                  }),
                              if (state.selectedType["value"] ==
                                  orderHistoryBloc.orderStatus[index]["value"])
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.indigo,
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
