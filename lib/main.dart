import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF0D131A),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/valorant_icon.svg',
                      width: 96,
                      height: 96,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Choose your awesome agents',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TabItem(
                        title: 'Popular',
                        checked: true,
                      ),
                      TabItem(
                        title: 'Popular',
                        checked: false,
                      ),
                      TabItem(
                        title: 'Popular',
                        checked: false,
                      ),
                    ],
                  ),
                  Container(
                    height: 400,
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF2fdddeff)
                                    // "2fdddeff",
                                    // "4f53afff",
                                    // "344673ff",
                                    // "193b3dff"
                                  ],
                                  tileMode: TileMode.decal,
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.title,
    required this.checked,
  });

  final String title;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: checked
                  ? const Color(
                      0xFFDD3B4F,
                    )
                  : Colors.grey,
              fontSize: 24),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 5,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(9),
            color: checked
                ? const Color(
                    0xFFDD3B4F,
                  )
                : Colors.grey,
          ),
        ),
      ],
    );
  }
}
