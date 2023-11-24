// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/core/config/theme/app_colors.dart';
import 'package:devmandu/core/widgets/annoted_region.dart';
import 'package:devmandu/features/message/pages/messaged_user_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:devmandu/core/config/route/route_name.dart';
import 'package:devmandu/features/internet_checker/widgets/internet_checker_widget.dart';
import 'package:devmandu/features/navbar/blocs/change_navbar_index_cubit/change_navbar_indexer_cubit.dart';

import '../../article/pages/home_page.dart';
import '../../profile/pages/profile_page.dart';
import '../../searcg/pages/search_article.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage>
    with AutomaticKeepAliveClientMixin {
  late final PageController _pageController;

  final List<Widget> _widgets = const [
    HomePage(),
    SearchArticlePage(),
    SizedBox(),
    MessagedUserPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildNavbarBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildNavbarBody() {
    return CustomAnnotatedRegion(
      color: Colors.grey.shade100,
      child: InternetCheckerWidget(
          child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: _widgets.length,
              itemBuilder: (context, index) {
                return _widgets[index];
              })),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<ChangeNavbarIndexerCubit, ChangeNavbarIndexerState>(
      builder: (context, state) {
        return BottomNavigationBar(
            backgroundColor: Colors.grey.shade100,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            useLegacyColorScheme: true,
            type: BottomNavigationBarType.fixed,
            unselectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            selectedIconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.primary),
            onTap: (index) {
              if (index == 2) {
                _onCreatePost();
                return;
              }
              context.read<ChangeNavbarIndexerCubit>().changeIndex(index);
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.linear);
            },
            currentIndex: state.index,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.house_outlined),
                  activeIcon: Icon(Icons.house),
                  label: 'Home'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: _addIcon(), label: 'Create article'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined),
                  activeIcon: Icon(Icons.message_rounded),
                  label: 'Notifications'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile'),
            ]);
      },
    );
  }

  Widget _addIcon() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: AppColors.greyScale7,
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[2]),
      child: const Icon(Icons.add),
    );
  }

  void _onCreatePost() {
    Navigator.of(context).pushNamed(AppRouteName.createArticle);
  }

  @override
  bool get wantKeepAlive => true;
}
