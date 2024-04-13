import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innwa_mobile_dev/_application/extension/color.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class ProductSpecificationSection extends StatelessWidget {
  const ProductSpecificationSection({required this.data, super.key});
  final ProductDetailsPriceModel data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...data.productSpecifications.map(
          (e) => Column(
            children: [
              Row(
                children: [
                  RobotoText(
                    fontSize: 16,
                    text: "${e.specificationType.enName} : ",
                    fontColor: null,
                    fontWeight: FontWeight.w500,
                  ),
                  Flexible(
                    child: RobotoText(
                      fontSize: 16,
                      text: e.specificationValue.value,
                      fontColor: null,
                      maxLine: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (e.specificationType.enName == "Color") 10.horizontal,
                  if (e.specificationType.enName == "Color")
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color:
                            HexColor.fromHex(e.specificationValue.colorCode!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
