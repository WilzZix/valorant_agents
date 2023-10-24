import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/agents/agents_bloc.dart';
import 'package:volarant_agents/presentation/components/tab_item_widget.dart';
import 'package:volarant_agents/presentation/home_page/home_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                buildWhen: (context, state) {
                  return state is AgentsLoadedState;
                },
                builder: (context, state) {
                  if (state is AgentsLoadedState) {
                    return SizedBox(
                      height: 600,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: state.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              context.push('/detail',
                                  extra: state.data[index].uuid);
                            },
                            child: Stack(
                              children: [
                                ClipPath(
                                  clipper: CustomClipPath(),
                                  child: Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.alphaBlend(
                                          octToColor(state.data[index]
                                              .backgroundGradientColors![1]),
                                          octToColor(state.data[index]
                                              .backgroundGradientColors![3])),
                                      // gradient: LinearGradient(
                                      //   begin: Alignment.topCenter,
                                      //   end: Alignment.bottomCenter,
                                      //   colors: [
                                      //     octToColor(state.data[index]
                                      //         .backgroundGradientColors![0]),
                                      //     octToColor(state.data[index]
                                      //         .backgroundGradientColors![1]),
                                      //     octToColor(state.data[index]
                                      //         .backgroundGradientColors![2]),
                                      //     octToColor(state.data[index]
                                      //         .backgroundGradientColors![3]),
                                      //   ],
                                      //   tileMode: TileMode.decal,
                                      // ),
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                ),
                                CachedNetworkImage(
                                  height: 600,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      'https://media.valorant-api.com/agents/${state.data[index].uuid}/fullportrait.png',
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ),
                                    if (state.data[index].role != null)
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            state.data[index].role!
                                                    .displayName! ??
                                                "",
                                            style: const TextStyle(
                                                fontSize: 18,
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
    );
  }
}