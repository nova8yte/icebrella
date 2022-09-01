import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:icebrella_health/ui/widgets/settings/settings_item_btn.dart';
import 'package:icebrella_health/utils/shared_keys.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';
import 'package:icebrella_health/ui/widgets/gradient_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackgroundGr,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              InkWell(
                customBorder: const CircleBorder(),
                child: AppIcons.icon_back(),
                onTap: () => Modular.to.pop(context),
              ),
              const SizedBox(width: 9),
              Column(
                children: [
                  GradientText(
                    "Settings",
                    gradient: AppColors.appBarTextGr,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 40),
          constraints: BoxConstraints.tight(MediaQuery.of(context).size),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SettingsItemBtn(
                  text: "Theme", iconData: Icons.palette_sharp),
              _divider,
              const SettingsItemBtn(
                  text: "Language", iconData: CupertinoIcons.globe),
              _divider,
              SettingsItemBtn(
                text: "About",
                iconData: CupertinoIcons.info,
                onPressed: () => Modular.to.pushNamed('/about'),
              ),
              _divider,
              SettingsItemBtn(
                  text: "Dev",
                  iconData: CupertinoIcons.chevron_left_slash_chevron_right,
                  onPressed: () => _switchOnboarding(context)),
            ],
          ),
        ),
      ),
    );
  }

  static Divider get _divider => const Divider(
        indent: 31,
        endIndent: 31,
        height: 0.5,
        thickness: 1,
        color: AppColors.inactiveIcon,
      );

  void _switchOnboarding(BuildContext context) {
    final _instance = GetIt.instance<SharedPreferences>();
    final newValue =
        !(_instance.getBool(SharedKeys.finishedOnboarding) ?? false);
    _instance.setBool(SharedKeys.finishedOnboarding, newValue);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${SharedKeys.finishedOnboarding} set to $newValue'),
    ));
  }
}
