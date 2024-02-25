import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    String htmlTag = r"""
<p id='top'><a href='#bottom'>Scroll to bottom</a></p>
      <h1>Header 1</h1>
      <h2>Header 2</h2>""";

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("About Us",
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
    );
  }
}
