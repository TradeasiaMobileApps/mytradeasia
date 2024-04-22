import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mytradeasia/features/domain/entities/country_entities/country_entity.dart';

import '../../../config/themes/theme.dart';
import '../pages/menu/other/languages_screen.dart';

class CountryPicker extends StatefulWidget {
  final ValueChanged<CountryEntity> onChanged;
  final bool suffixIconMode;
  final bool readOnly;
  const CountryPicker({
    super.key,
    required this.onChanged,
    this.suffixIconMode = false,
    this.readOnly = false,
  });

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  ValueNotifier<CountryEntity> country =
      ValueNotifier<CountryEntity>(const CountryEntity(
    name: "indonesia",
    codeCountry: "ID",
    flagUrl: "https://flagcdn.com/w320/id.png",
    phoneCode: "+62",
  ));
  @override
  Widget build(BuildContext context) {
    return widget.suffixIconMode
        ? IconButton(
            onPressed: !widget.readOnly
                ? () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LanguagesScreen(
                          onChanged: widget.onChanged,
                          country: country,
                        );
                      },
                    ));
                  }
                : null,
            icon: Image.asset("assets/images/icon_forward.png",
                width: 24.0, height: 24.0),
          )
        : InkWell(
            onTap: !widget.readOnly
                ? () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LanguagesScreen(
                          onChanged: widget.onChanged,
                          country: country,
                        );
                      },
                    ));
                  }
                : null,
            child: ValueListenableBuilder<CountryEntity>(
              valueListenable: country,
              builder: (context, value, child) {
                return Container(
                  height: 48,
                  width: size20px * 3,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(7),
                      ),
                      border: Border.all(color: greyColor3)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: country.value.flagUrl!,
                          fit: BoxFit.cover,
                        )),
                  ),
                );
              },
            ));
  }
}
