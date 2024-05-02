import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/about_us/bloc/about_us_bloc.dart';
import 'package:innwa_mobile_dev/about_us/widgets/branch_section.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutUsBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      ),
      child: Builder(
        builder: (context) {
          final AboutUsBloc aboutUsBloc = BlocProvider.of<AboutUsBloc>(context)
            ..add(GetBranchEvent(context: context));
          return Scaffold(
            appBar: TopBar(
              needBackButton: false,
              needMenu: true,
            ),
            drawer: CustomDrawerWidget(
              onDrawerTap: () {},
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: LocalizationWidget(
                        en: "About Us",
                        mm: "ကျွန်ုပ်တို့အကြောင်း",
                        child: (val) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RobotoText(
                                fontSize: 18,
                                fontColor: null,
                                text: val,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          );
                        }),
                  ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  SliverToBoxAdapter(
                    child: RobotoText(
                      fontSize: 16,
                      fontColor: null,
                      text: "INNWA IT & Mobile",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  SliverToBoxAdapter(
                    child: RobotoText(
                      fontSize: 16,
                      fontColor: null,
                      text:
                          "Golden Mega Technology (G.M.T) Co., Ltd. သည် ထုတ်ကုန်များ၊ ဝန်ဆောင်မှုများနှင့် အလှည့်ကျဖြေရှင်းချက်များစွာကို ပေးဆောင်သည့် ထိပ်တန်းနည်းပညာဖြေရှင်းချက်ပေးသူနှင့် ဖြန့်ဖြူးသူဖြစ်သည်။ ကျွန်ုပ်တို့သည် တစ်ဦးချင်းစီ၊ အသေးစားနှင့် အလတ်စားစီးပွားရေးလုပ်ငန်းများနှင့် ကြီးမားသောစီးပွားရေးလုပ်ငန်းများကို တိုးတက်အောင်မြင်စေရန်အတွက် ဆန်းသစ်သောသတင်းအချက်အလက်နှင့် ဆက်သွယ်ရေးနည်းပညာ (ICT) ဖြေရှင်းချက်များကို ပံ့ပိုးပေးပါသည်။ ကွန်ပျူတာထုတ်ကုန်များ၊ ကွန်ရက်သုံးပစ္စည်းများ၊ ဝန်ဆောင်မှုများနှင့် ဖြေရှင်းချက်များစွာဖြင့် ၎င်းတို့၏ အိုင်တီအခြေခံအဆောက်အအုံကို စီစဉ်ခြင်း၊ အလုပ်ခန့်ခြင်းနှင့် စီမံခန့်ခွဲခြင်းတို့ကို အောင်မြင်စေပါသည်။ ဖောက်သည်များ၏လိုအပ်ချက်များကိုဖြည့်ဆည်းရန်ဒီဇိုင်းပြုလုပ်ထားသည်။",
                      maxLine: 100,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  BlocBuilder<AboutUsBloc, AboutUsState>(
                    builder: (context, state) {
                      return const SliverToBoxAdapter(
                        child: BranchSection(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "About Us",
                    style: TextStyle(
                        fontFamily: 'SanFrancisco',
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
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
