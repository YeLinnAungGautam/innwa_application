import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/order/order_history/bloc/order_history_bloc.dart';
import 'package:innwa_mobile_dev/order/order_history/widgets/order_history.dart';
import 'package:innwa_mobile_dev/order/order_history/widgets/order_pending.dart';
import 'package:innwa_mobile_dev/order/order_history/widgets/order_type.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: BlocProvider(
        create: (context) =>
            OrderHistoryBloc(BlocProvider.of<AppServiceBloc>(context).api),
        child: SafeArea(
          child: Scaffold(
            appBar: TopBar(
              needBackButton: true,
              needMenu: false,
              title: "My Account",
            ),
            body: CustomScrollView(
              slivers: [
                const OrderTab(),
                SliverToBoxAdapter(
                  child: 20.vertical,
                ),
                BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
                  buildWhen: (prev, current) {
                    return prev.selectedTab != current.selectedTab;
                  },
                  builder: (context, state) {
                    return state.selectedTab == 0
                        ? const OrderHistory()
                        : const OrderPending();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
