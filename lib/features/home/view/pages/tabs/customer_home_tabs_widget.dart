import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/home_view.dart';
import 'package:driver_hub_partner/features/home/view/widgets/tabs/tabs_icon_widget.dart';
import 'package:driver_hub_partner/features/profile/view/pages/profile_view.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/schedules_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:flutter_svg/svg.dart';

class CustomerHomeTabsWidget extends StatefulWidget {
  const CustomerHomeTabsWidget({super.key});

  @override
  State<CustomerHomeTabsWidget> createState() => _CustomerHomeTabsWidgetState();
}

class _CustomerHomeTabsWidgetState extends State<CustomerHomeTabsWidget> {
  var _index = 1;

  void changeTab(int indexOfTabClicked) {
    setState(() {
      _index = indexOfTabClicked;
    });
  }

  @override
  void initState() {
    context.read<HomePresenter>().load();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var preselectedIndex = ModalRoute.of(context)!.settings.arguments as int?;
    _index = preselectedIndex ?? 0;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leadingWidth: double.infinity,
        leading: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "lib/assets/images/LogoWhite.svg",
                  height: 24,
                ),
              ],
            )),
        actions: null,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          border:
              Border(top: BorderSide(color: AppColor.borderColor, width: 1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabIconWidget(
                icon: CustomIcons.dhGarage,
                text: "Home",
                indexOfTab: 0,
                selectedTab: _index,
                onClick: changeTab,
              ),
              TabIconWidget(
                icon: CustomIcons.dhCalendarCheck,
                text: "Agendamentos",
                indexOfTab: 1,
                selectedTab: _index,
                onClick: changeTab,
              ),
              TabIconWidget(
                icon: CustomIcons.dhUser,
                text: "Conta",
                indexOfTab: 2,
                selectedTab: _index,
                onClick: changeTab,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: const [HomeView(), SchedulesView(), HomeProfileView()],
        ),
      ),
    );
  }
}
