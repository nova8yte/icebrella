import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icebrella_health/bloc/home/home_bloc.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';
import 'package:icebrella_health/ui/screens/home/home_widget.dart';
import 'package:icebrella_health/ui/screens/notify/notify_widget.dart';
import 'package:icebrella_health/ui/screens/profile/profile_widget.dart';
import 'package:icebrella_health/ui/screens/stats/stats_widget.dart';
import 'package:icebrella_health/ui/widgets/gradient_text.dart';

class HomeScreen extends StatelessWidget {
  final PageController pageController = PageController(initialPage: 0);

  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(listener: (context, state) {
      if (state is NextPageState &&
          state.currentPage != (pageController.page ?? 0.0).toInt() - 1 &&
          state.currentPage != (pageController.page ?? 0.0).toInt() + 1) {
        pageController.animateToPage(state.currentPage,
            duration: const Duration(milliseconds: 450),
            curve: Curves.fastOutSlowIn);
      } else {
        pageController.animateToPage(state.currentPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn);
      }
    }, child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.homeBackgroundGr,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: AppIcons.sunset,
                ),
                const SizedBox(width: 9),
                GradientText(
                  "Your\nMedicine Reminder",
                  gradient: AppColors.appBarTextGr,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
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
          floatingActionButton: (state.currentPage != 0)
              ? null
              : FloatingActionButton(
                  child: const Icon(
                    Icons.add,
                    color: AppColors.activeIcon,
                  ),
                  backgroundColor: AppColors.white,
                  onPressed: () => Modular.to.pushNamed('/medication/new'),
                ),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
            currentIndex: state.currentPage,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontSize: 0),
            unselectedLabelStyle: const TextStyle(fontSize: 0),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: AppIcons.estate(),
                  activeIcon: AppIcons.estate_active,
                  label: "home"),
              BottomNavigationBarItem(
                  icon: AppIcons.chart(),
                  activeIcon: AppIcons.chart_active,
                  label: "labs"),
              BottomNavigationBarItem(
                  icon: AppIcons.bell(),
                  activeIcon: AppIcons.bell_active,
                  label: "notify"),
              BottomNavigationBarItem(
                  icon: AppIcons.user_circle(),
                  activeIcon: AppIcons.user_circle_active,
                  label: "profile"),
            ],
            onTap: (int page) => BlocProvider.of<HomeBloc>(context)
                .add(NextPage(nextPage: page)),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeWidget(),
                StatsWidget(),
                NotifyWidget(),
                ProfileWidget(),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
