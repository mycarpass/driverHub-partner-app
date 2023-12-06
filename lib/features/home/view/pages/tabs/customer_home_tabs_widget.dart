import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:driver_hub_partner/features/customers/view/pages/home/customers_view.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/home_view.dart';
import 'package:driver_hub_partner/features/profile/view/pages/profile_view.dart';
import 'package:driver_hub_partner/features/sales/view/pages/home/sales_view.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/schedules_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomerHomeTabsWidget extends StatefulWidget {
  const CustomerHomeTabsWidget({super.key});

  @override
  State<CustomerHomeTabsWidget> createState() => _CustomerHomeTabsWidgetState();
}

class _CustomerHomeTabsWidgetState extends State<CustomerHomeTabsWidget>
    with TickerProviderStateMixin {
  var _index = 0;

  void changeTab(int indexOfTabClicked) {
    setState(() {
      _index = indexOfTabClicked;
    });
  }

  @override
  void initState() {
    context.read<HomePresenter>().load();

    tabController = TabController(
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // var preselectedIndex = ModalRoute.of(context)!.settings.arguments as int?;
    // _index = preselectedIndex ?? 0;
    dynamic args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      if (args['index'] != null) {
        _index = args['index'] ?? 0;
      }
      //    var preselectedIndex = args as int?;
      if (args['deeplink'] != null) {
        context.read<HomePresenter>().deepLink = args['deeplink'].toString();
      }
    }
    super.didChangeDependencies();
  }

  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorColor: AppColor.accentColor,
                padding: const EdgeInsets.only(left: 16),
                tabs: const [
                  TabBarWidget(
                    icon: Icons.home_outlined,
                    title: "Home",
                  ),
                  TabBarWidget(
                    icon: Icons.calendar_month_outlined,
                    title: "Agenda",
                  ),
                  TabBarWidget(
                    icon: Icons.monetization_on_outlined,
                    title: "Vendas",
                  ),
                  TabBarWidget(
                    icon: Icons.group_outlined,
                    title: "Clientes",
                  ),
                  TabBarWidget(
                    icon: Icons.account_box_outlined,
                    title: "Perfil",
                  ),
                ],
              )),
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
        // bottomNavigationBar: Container(
        //   decoration: const BoxDecoration(
        //     color: AppColor.backgroundColor,
        //     border:
        //         Border(top: BorderSide(color: AppColor.borderColor, width: 1)),
        //   ),
        //   padding: const EdgeInsets.symmetric(horizontal: 42),
        //   child: Padding(
        //     padding: const EdgeInsets.only(bottom: 40.0, top: 8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         TabIconWidget(
        //           icon: CustomIcons.dhGarage,
        //           text: "Home",
        //           indexOfTab: 0,
        //           selectedTab: _index,
        //           onClick: changeTab,
        //         ),
        //         TabIconWidget(
        //           icon: CustomIcons.dhCalendarCheck,
        //           text: "Agendamentos",
        //           indexOfTab: 1,
        //           selectedTab: _index,
        //           onClick: changeTab,
        //         ),
        //         TabIconWidget(
        //           icon: CustomIcons.dhUser,
        //           text: "Conta",
        //           indexOfTab: 2,
        //           selectedTab: _index,
        //           onClick: changeTab,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: TabBarView(
            controller: tabController,
            children: const [
              HomeView(),
              SchedulesView(),
              SalesView(),
              CustomersView(),
              HomeProfileView(),
            ],
          ),
        )

        //     SafeArea(
        //   child: IndexedStack(
        //     index: _index,
        //     children: const [HomeView(), SchedulesView(), HomeProfileView()],
        //   ),
        // ),
        );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 8,
          ),
          Text(title)
        ],
      ),
    );
  }
}
