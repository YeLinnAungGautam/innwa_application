import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/article/components/article_lists.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';

class Article extends StatelessWidget {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                Heading(text: "Articles"),
              ],
            ),
    
          SizedBox(
            height: MediaQuery.of(context).size.height/1.53,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return  ArticleLists();
                
              },
              
              ),
          )
        ],
    );
  }
}