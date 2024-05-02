import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/color.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/product_details/model/select_specification_model.dart';

class SelectColors extends StatefulWidget {
  final List<SpecificationvalueModel> colors;
  final Function(SpecificationvalueModel data) onClick;
  const SelectColors({super.key, required this.colors, required this.onClick});

  @override
  State<SelectColors> createState() => _SelectColorsState();
}

class _SelectColorsState extends State<SelectColors> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colors.length,
        itemBuilder: (context, index) {
          return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              final bool isSelected = state.selectedSpec
                  .where((e) =>
                      e.id == widget.colors[index].id &&
                      e.specificationTypeId ==
                          widget.colors[index].specificationTypeId)
                  .isNotEmpty;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      widget.onClick(widget.colors[index]);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor.fromHex(
                                  widget.colors[index].colorCode!),
                              border: Border.all(
                                  width: 3,
                                  color:
                                      isSelected ? Colors.black : Colors.white,
                                  strokeAlign: BorderSide.strokeAlignInside)),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: HexColor.fromHex(
                                    widget.colors[index].colorCode!),
                                border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                    strokeAlign: BorderSide.strokeAlignInside)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            widget.colors[index].value.toLowerCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
