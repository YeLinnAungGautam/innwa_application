import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/order/order_history/bloc/order_history_bloc.dart';
import 'package:innwa_mobile_dev/order/order_history/model/order_history_model.dart';
import 'package:innwa_mobile_dev/order/order_history/widgets/order_item.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/ui/error_retry.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      BlocProvider.of<OrderHistoryBloc>(context)
          .add(GetOrderHistoryEvent(context: context));
      return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
          return state.historyStatus == ApiStatus.completed
              ? state.orderHistory.isNotEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList.builder(
                        itemCount: state.orderHistory.length,
                        itemBuilder: (context, index) {
                          final OrderHistoryModel order =
                              state.orderHistory[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.vertical,
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: RobotoText(
                                  fontSize: 18.0,
                                  fontColor: Colors.black,
                                  text: DateFormat('dd MMM yyyy')
                                      .format(DateTime.parse(order.orderAt)),
                                ),
                              ),
                              10.vertical,
                              OrderItem(
                                isHistory: true,
                                orderNo: order.orderNo,
                                subTotal: order.subTotal,
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          alignment: Alignment.center,
                          child: LocalizationWidget(
                              en: "No Order Found!",
                              mm: "အော်ဒါများမတွေ့ပါ",
                              child: (val) {
                                return RobotoText(
                                  fontSize: 18,
                                  fontColor:
                                      Theme.of(context).colorScheme.primary,
                                  text: val,
                                  fontWeight: FontWeight.w600,
                                );
                              }),
                        ),
                      ),
                    )
              : state.historyStatus == ApiStatus.processing
                  ? const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SliverFillRemaining(
                      child: ErrorRetry(
                        retryFun: () {
                          BlocProvider.of<OrderHistoryBloc>(context)
                              .add(GetOrderHistoryEvent(context: context));
                        },
                      ),
                    );
        },
      );
    });
  }
}
