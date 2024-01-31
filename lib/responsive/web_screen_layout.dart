// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          // ignore:
          title: SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(
              onPressed: () => navigationTapped(0),
              color: _page == 0 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () => navigationTapped(1),
              color: _page == 1 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () => navigationTapped(2),
              color: _page == 2 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.photo),
            ),
            IconButton(
              onPressed: () => navigationTapped(3),
              color: _page == 3 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () => navigationTapped(4),
              color: _page == 4 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: PageView(
          physics:const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChange,
          children: homeScreenItems,
        ));
  }
}
