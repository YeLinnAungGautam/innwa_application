import 'package:flutter/material.dart';

class ItemCountrol extends StatefulWidget {
  final Function() updateQty;
  final Function() reduceQty;
  final int qty;
  const ItemCountrol(
      {super.key,
      required this.updateQty,
      required this.reduceQty,
      required this.qty});

  @override
  State<ItemCountrol> createState() => _ItemCountrolState();
}

class _ItemCountrolState extends State<ItemCountrol> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                widget.reduceQty();
              },
              icon: const Icon(
                Icons.remove,
                size: 18,
              )),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(7.0)),
            child: Center(child: Text(widget.qty.toString())),
          ),
          IconButton(
              onPressed: () {
                widget.updateQty();
              },
              icon: const Icon(
                Icons.add,
                size: 18,
              )),
        ],
      ),
    );
  }
}
