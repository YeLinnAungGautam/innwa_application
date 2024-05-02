import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/product_details/model/select_specification_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class SelectStorage extends StatefulWidget {
  final List<SpecificationvalueModel> data;
  final Function(SpecificationvalueModel data) onClick;

  const SelectStorage({super.key, required this.data, required this.onClick});

  @override
  State<SelectStorage> createState() => _SelectStorageState();
}

class _SelectStorageState extends State<SelectStorage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.05,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              final bool isSelected = state.selectedSpec
                  .where((e) =>
                      e.id == widget.data[index].id &&
                      e.specificationTypeId ==
                          widget.data[index].specificationTypeId)
                  .isNotEmpty;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      widget.onClick(widget.data[index]);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(5),
                              color: isSelected
                                  ? Colors.blue[400]!
                                  : Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: RobotoText(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontColor:
                                    isSelected ? Colors.white : Colors.black,
                                text: widget.data[index].value,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
