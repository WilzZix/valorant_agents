import 'package:flutter/material.dart';
import 'package:volarant_agents/presentation/pages/favourite_page/favourite_page.dart';
import 'package:volarant_agents/presentation/pages/list_page/list_page.dart';
import 'package:volarant_agents/presentation/pages/profile_page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

Color octToColor(String code) {
  return Color(int.parse('0xff$code'));
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final _buildBody = const <Widget>[
    ListPage(),
    FavouritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D131A),
      body: _buildBody[selectedIndex],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();

    path.lineTo(0, h);
    path.lineTo(0, h);
    path.lineTo(w, h);

    path.quadraticBezierTo(
      w * 0.5,
      h - 100,
      w,
      0,
    );
    path.quadraticBezierTo(
      w * 0.5,
      h - 100,
      0,
      0,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
