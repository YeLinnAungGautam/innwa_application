import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/screen/profile/profile.dart';
import 'package:innwa_mobile_dev/shared/avatar/avatar.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/utility_component/utility_component.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class CustomDrawerWidget extends StatelessWidget {
  final VoidCallback onDrawerTap;
  const CustomDrawerWidget({super.key, required this.onDrawerTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          color: backgroundColorLight,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: BlocBuilder<AppServiceBloc, AppServiceState>(
                        builder: (context, state) {
                          return logoImage(link: state.site!.siteLogoPath);
                        },
                      ),
                    ),
                    InkWell(
                        onTap: () => Scaffold.of(context).closeDrawer(),
                        child: const Icon(
                          Icons.menu_open,
                          size: 30,
                        ))
                  ],
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile())),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Avatar(
                            image:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp2lasl_QjsB0vVpouDq_SQz3yPQrnwC0W9w&usqp=CAU",
                            width: 60,
                            height: 60),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RobotoText(
                                fontSize: 18.0,
                                fontColor: Colors.black87,
                                text: "Takina Inoue",
                                fontWeight: FontWeight.bold),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    left: 15.0,
                                    right: 15.0),
                                child: RobotoText(
                                    fontSize: 12.0,
                                    fontColor: Colors.white,
                                    text: "ID:123123123"),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18.0,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 1),
              const UtilityComponent()
            ],
          ),
        ),
      ),
    );
  }
}

Widget logoImage({required String link}) {
  return SizedBox(
    width: 110,
    height: 40,
    child: SvgPicture.network(link),
  );
}
