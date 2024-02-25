import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          appBar: TopBar(
            needBackButton: true,
            needMenu: false,
            title: "Article Detail",
          ),
          drawer: CustomDrawerWidget(onDrawerTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
              currentFocus.unfocus();
            }
          }),
          body: SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text("Article Detail Heading",
                                style: TextStyle(
                                    fontFamily: 'SanFrancisco',
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://fujifilm-x.com/wp-content/uploads/2021/01/gfx100s_sample_04_thum-1.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RobotoText(
                            maxLine: 5,
                            fontSize: 15.0,
                            fontColor: Colors.black,
                            text:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
