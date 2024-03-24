import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.filter_alt_sharp), Text('Filter By')],
        )),
      ),
    );
  }
}
