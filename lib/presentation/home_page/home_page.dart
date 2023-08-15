import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/agents/agents_bloc.dart';
import 'package:volarant_agents/presentation/components/tab_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color octToColor(String code) {
    return Color(int.parse('0xff$code'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    fontSize: 40,
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
                      title: 'New One',
                      checked: false,
                    ),
                    TabItem(
                      title: 'Trending',
                      checked: false,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                BlocBuilder<AgentsBloc, AgentsState>(
                  builder: (context, state) {
                    if (state is AgentsLoadedState) {
                      return SizedBox(
                        height: 600,
                        child: GridView.builder(
                          itemCount: state.data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                context.push('/detail');
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          octToColor(state.data[index]
                                              .backgroundGradientColors![0]),
                                          octToColor(state.data[index]
                                              .backgroundGradientColors![1]),
                                          octToColor(state.data[index]
                                              .backgroundGradientColors![2]),
                                          octToColor(state.data[index]
                                              .backgroundGradientColors![3]),
                                        ],
                                        tileMode: TileMode.decal,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    // placeholder: (context, url) =>
                                    //     const Center(child: CircularProgressIndicator()),
                                    // errorWidget: (context, url, error) =>
                                    //     const Icon(Icons.error),
                                    imageUrl:
                                        'https://media.valorant-api.com/agents/${state.data[index].uuid}/fullportrait.png',
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 105,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8),
                                        child: Text(
                                          state.data[index].displayName!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                      ),
                                      if (state.data[index].role != null)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.data[index].role!
                                                      .displayName! ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
