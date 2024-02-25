import 'package:flutter/material.dart';

class ItemCountrol extends StatefulWidget {
  final Function() updateQty;
  final Function() reduceQty;
  const ItemCountrol({super.key, required this.updateQty, required this.reduceQty});

  @override
  State<ItemCountrol> createState() => _ItemCountrolState();
}

class _ItemCountrolState extends State<ItemCountrol> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(       
        children: [
          IconButton(onPressed: (){
            count == 1 ? count =1 : setState(() {
              count --;
              widget.reduceQty();
            });
          }, icon: Icon(Icons.remove,size: 18,)),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey),
              borderRadius: BorderRadius.circular(7.0)
            ),
            child: Center(child: Text(count.toString())),
          ),
          IconButton(onPressed: (){
            setState(() {
              count ++;
              widget.updateQty();
            });
          }, icon: Icon(Icons.add,size: 18,)),
        ],
      ),
    );
  }
}