import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/order/order_history/bloc/order_history_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class StatusSelectUi extends StatelessWidget {
  const StatusSelectUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        final OrderHistoryBloc orderHistoryBloc =
            BlocProvider.of<OrderHistoryBloc>(context);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              LocalizationWidget(
                en: "Select Status",
                mm: "အခြေအနေကိုရွေးပါ",
                child: (val) {
                  return SliverAppBar(
                    pinned: true,
                    title: Text(val),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: 15.vertical,
              ),
              SliverList.builder(
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
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
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
                                en: orderHistoryBloc.orderStatus[index]["key"],
                                mm: orderHistoryBloc.orderStatus[index]
                                    ["mmkey"],
                                child: (val) {
                                  return RobotoText(
                                    fontSize: 14,
                                    fontColor: null,
                                    text: val,
                                  );
                                }),
                            if (state.selectedType["value"] ==
                                orderHistoryBloc.orderStatus[index]["value"])
                              const Icon(Icons.check),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}
