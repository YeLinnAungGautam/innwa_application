import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/products/components/filter_button.dart';
import 'package:innwa_mobile_dev/screen/promotion/components/promotion_thumbnail.dart';
import 'package:innwa_mobile_dev/shared/banner/image_banner.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';


class Promotion extends StatefulWidget {
  const Promotion({super.key});

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  List<String> filterTypes = ['Best Selling', 'Most Popular', 'New Arrival'];
  List<String> selectTypes = [];
  
  @override
  Widget build(BuildContext context) {

    

    Map<dynamic,dynamic> products = {
     
       "product_one" : {
        "image" : "https://innwa.com.mm/images/products/apple/ipad/637c8d362a249/637c8d362a249ipad_pro_12_9_wif.jpg",
        "name" : "SAMSUNG GALAXY A4",
        "price" : "123,000"
      },     
     
     
       "product_two" : {
        "image" : "https://innwa.com.mm/images/products/smartphone/nokia/63414a52348fc/63414a52348fcnokia105.jpg",
        "name" : "Redmi Note 11 E Pro",
        "price" : "123,000"
      },      
     
     
      "product_three" : {
        "image" : "https://innwa.com.mm/images/products/smartphone/oppo/65446b8c6cb18/65446b8c6cb18Oppo-Find-N3-flip.webp",
        "name" : "RealMe CC3",
        "price" : "123,000"
      },     
     
     
       "product_4" : {
        "image" : "https://innwa.com.mm/images/products/smartphone/huawei/646b285f9fa4a/646b285f9fa4ahuawei-mateX3.png",
        "name" : "Xiaomi 13 Lite",
        "price" : "123,000"
      },   

      "product_5" : {
        "image" : "https://innwa.com.mm/images/products/smartphone/oppo/65446b8c6cb18/65446b8c6cb18Oppo-Find-N3-flip.webp",
        "name" : "RealMe CC3",
        "price" : "123,000"
      },     
     
     
       "product_6" : {
        "image" : "https://innwa.com.mm/images/products/smartphone/huawei/646b285f9fa4a/646b285f9fa4ahuawei-mateX3.png",
        "name" : "Xiaomi 13 Lite",
        "price" : "123,000"
      },  

    };
    
    return SizedBox(
      height: MediaQuery.of(context).size.height/1.32 ,
      child: SingleChildScrollView(
        child: Column(
          children: [
            PromotionThumbnail(),
             GridView.count(
                 physics: const NeverScrollableScrollPhysics(),
                 childAspectRatio: MediaQuery.of(context).size.width<=600?  0.6 :0.65,
                 shrinkWrap: true,
                 crossAxisCount:  MediaQuery.of(context).size.width<=600? 2:3,
                 semanticChildCount: 4,
                 children: products.entries.map((e) => ProductCard(url: e.value["image"], text: e.value["name"], price: "")).toList()             
                 
               ),
                ImageBanner(url: "url"),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: FilterButton(),
                ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: PromotionFilterButton(),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: PromotionSortButton(),
              //     )
              //   ],
              // ),

              Row(
                children: [
                  Heading(text: "Best Selling Products"),
                ],
              ),
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
                  shrinkWrap: true,
                  crossAxisCount:
                      MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                  semanticChildCount: 4,
                  children: products.entries
                      .map((e) => ProductCard(
                          url: e.value["image"],
                          text: e.value["name"],
                          price: ""))
                      .toList()),

              
              
          ],
        ),
      ),
    );
    // return SizedBox(
    //   height: MediaQuery.of(context).size.height/1.6,
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: 1,
    //     itemBuilder: (context, index) {
    //       return
    //       Column(
    //      children: [
    //        PromotionThumbnail(),
    //        GridView.count(
    //            physics: const NeverScrollableScrollPhysics(),
    //            childAspectRatio: MediaQuery.of(context).size.width<=600?  0.6 :0.65,
    //            shrinkWrap: true,
    //            crossAxisCount:  MediaQuery.of(context).size.width<=600? 2:3,
    //            semanticChildCount: 4,
    //            children: products.entries.map((e) => ProductCard(url: e.value["image"], text: e.value["name"], price: "")).toList()             
               
    //          ),
    //      ],
    //     );
    //     },
         
    //   ),
    // );
  }
}