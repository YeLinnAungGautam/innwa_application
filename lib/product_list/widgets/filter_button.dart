import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({required this.onClick, super.key});
  final VoidCallback onClick;

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(),
      // onTap: () => Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const FilterBy())
      //     ),
      child: Container(
        width: 320,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: 0,
              blurRadius: 6,
              color: Color.fromRGBO(200, 199, 199, 1),
            )
          ],
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.filter_alt_sharp,
              size: 18,
            ),
            10.horizontal,
            LocalizationWidget(
              en: "Filter By",
              mm: "စစ်ထုတ်ခြင်း",
              child: (val) {
                return RobotoText(
                  fontSize: 18,
                  fontColor: null,
                  text: val,
                  fontWeight: FontWeight.w500,
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
