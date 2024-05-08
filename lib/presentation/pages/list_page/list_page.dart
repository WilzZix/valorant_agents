import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/agents/agents_bloc.dart';
import 'package:volarant_agents/application/home_page/home_page_cubit.dart';
import 'package:volarant_agents/presentation/components/tab_item_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({
    super.key,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String displayName = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomePageCubit>(context).getUserInfoCubit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is UserInfoLoaded) {
            displayName = state.userDate.displayName!;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: BlocBuilder<HomePageCubit, HomePageState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              displayName,
                              style: const TextStyle(color: Colors.white),
                            ),
                            SvgPicture.asset(
                              'assets/icons/valorant_icon.svg',
                              width: 96,
                              height: 96,
                            ),
                            GestureDetector(
                              onTap: () {
                                //TODO
                              },
                              child: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Choose Your\n Favourite Agents',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const TabItem(
                        title: 'Agents',
                        checked: true,
                      ),
                      Container(
                        height: 16,
                        width: 1,
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                      const TabItem(
                        title: 'Maps',
                        checked: false,
                      ),
                      Container(
                        height: 16,
                        width: 1,
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                      const TabItem(
                        title: 'Arsenal',
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
                          height: MediaQuery.of(context).size.height * .4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              Color color = HexColor.fromHex(
                                  '#${state.data[index].backgroundGradientColors![1]}');
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .4,
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: GestureDetector(
                                        onTap: () async {
                                          context.push('/detail',
                                              extra: state.data[index].uuid);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .38,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  'https://media.valorant-api.com/agents/${state.data[index].uuid}/fullportrait.png',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .7,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              12,
                                            ),
                                          ),
                                          color: Colors.white.withOpacity(.5),
                                        ),
                                        child: Column(
                                          children: [
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
                                            Container(
                                              height: 3,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                                color: Colors.grey,
                                              ),
                                            ),
                                            if (state.data[index].role != null)
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    state.data[index].role!
                                                        .displayName!,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
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
          );
        },
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
