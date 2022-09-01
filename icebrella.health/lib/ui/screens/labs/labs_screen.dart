import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';

class LabsScreen extends StatelessWidget {
  const LabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
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
              children: const [
                Text("labs",
                    style: TextStyle(
                        color: AppColors.appBarIcon,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: AppIcons.settings(),
            splashRadius: 20,
            onPressed: () => Modular.to.pushNamed('/settings'),
          )
        ],
      ),
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Center(
              child: Text("Nothing :(",
                  style: TextStyle(
                      color: AppColors.inactiveIcon,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14),
            padding: const EdgeInsets.all(28),
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                color: AppColors.timeAgoColorList[1],
                height: 148,
                minWidth: 139,
                elevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                disabledElevation: 0,
                highlightElevation: 0,
                onPressed: () {},
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 2,
                          child: Icon(
                            Icons.add,
                            color: Colors.white.withOpacity(0.67),
                            size: 35,
                          )),
                      const Spacer(),
                      Flexible(
                          flex: 10,
                          child: Text("Add some",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.67)))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
