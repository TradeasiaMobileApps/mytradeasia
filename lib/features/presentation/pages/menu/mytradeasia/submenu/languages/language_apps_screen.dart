import 'package:auto_localization/auto_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../config/themes/theme.dart';

class LanguageAppsScreen extends StatefulWidget {
  const LanguageAppsScreen({super.key});
  static TranslationWorker twr = TranslationWorker();

  @override
  State<LanguageAppsScreen> createState() => _LanguageAppsScreenState();
}

class _LanguageAppsScreenState extends State<LanguageAppsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listCountryName = [
      {
        "name": "Arabic",
        "images": "assets/images/saudi_arabia.png",
        "code": "hi"
      },
      {"name": "Chinese", "images": "assets/images/china.png", "code": "zh-cn"},
      {
        "name": "English(United States)",
        "images": "assets/images/unitedstates.png",
        "code": "en"
      },
      {
        "name": "Korean",
        "images": "assets/images/southkorea.png",
        "code": "ko"
      },
      {
        "name": "Portuguese",
        "images": "assets/images/portugal.png",
        "code": "pt"
      },
      {"name": "Spanish", "images": "assets/images/spain.png", "code": "es"},
      {
        "name": "Vietnames",
        "images": "assets/images/vietnam.png",
        "code": "vi"
      },
    ];
    List<String> listString = ["Choose Language"];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AutoLocalBuilder(
          text: listString,
          translationWorker: LanguageAppsScreen.twr,
          builder: (TranslationWorker tw) {
            return Text(tw.get("Choose Language"), style: heading2);
          },
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/images/icon_back.png",
              width: 24.0,
              height: 24.0,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: size20px),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listCountryName.length,
          itemBuilder: (context, index) {
            return Material(
              color: whiteColor,
              type: MaterialType.button,
              child: InkWell(
                onTap: () {
                  // AutoLocalBuilder(
                  //   text: const ["Sign Up Here"],
                  //   builder: (TranslationWorker tw) {
                  //     return Text(tw.get("Sign Up Here"));
                  //   },
                  // );
                  // AutoLocalization.setAppLanguage = "en";
                  AutoLocalization.setUserLanguage =
                      listCountryName[index]["code"];
                  LanguageAppsScreen.twr.set(listString);
                  LanguageAppsScreen.twr.run(useCache: true);
                  setState(() {});
                },
                child: Container(
                  height: size20px + 30.0,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: size20px + 8, vertical: size20px / 4.0),
                    child: Row(
                      children: [
                        Image.asset(
                          listCountryName[index]["images"],
                          width: size24px + 6,
                          height: size24px + 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: size20px + 3.0, right: size20px / 5),
                          child: Text(listCountryName[index]["name"],
                              style: body1Regular),
                        ),
                        Text("(+62)",
                            style: body1Regular.copyWith(color: greyColor2)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
