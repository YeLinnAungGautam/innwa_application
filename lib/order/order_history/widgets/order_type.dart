import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/order/order_history/bloc/order_history_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        return SliverAppBar(
          leadingWidth: 0,
          leading: const SizedBox(),
          toolbarHeight: 110,
          pinned: true,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.vertical,
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: RobotoText(
                    fontSize: 25,
                    fontColor: Theme.of(context).colorScheme.primary,
                    text: state.selectedTab == 0 ? "My Order" : "Pending",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                10.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<OrderHistoryBloc>(context).add(
                              UpdateSelectedTabEvent(
                                  selectedTab: 0, context: context));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: state.selectedTab == 0
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: 30.0,
                                  right: 30.0),
                              child: RobotoText(
                                fontSize: 16.0,
                                fontColor: state.selectedTab == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                                text: "History",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<OrderHistoryBloc>(context).add(
                              UpdateSelectedTabEvent(
                                  selectedTab: 1, context: context));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                color: state.selectedTab != 1
                                    ? Colors.transparent
                                    : Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: 30.0,
                                  right: 30.0),
                              child: RobotoText(
                                fontSize: 16.0,
                                fontColor: state.selectedTab != 1
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                                text: "Pending",
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
