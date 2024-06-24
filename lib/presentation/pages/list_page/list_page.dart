import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/agents/agents_bloc.dart';
import 'package:volarant_agents/application/connection_checker/connection_checker_bloc.dart';
import 'package:volarant_agents/application/connection_checker/connection_checker_state.dart';
import 'package:volarant_agents/application/home_page/home_page_cubit.dart';

class ListPage extends StatefulWidget {
  const ListPage({
    super.key,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String displayName = '';
  TextEditingController agentTextContr = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AgentsBloc>(context).add(GetAgentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is UserInfoLoaded) {
              displayName = state.displayName;
            }
            return BlocListener<ConnectionCheckerBloc, ConnectionCheckerState>(
              listener: (context, state) {
                if (state is ConnectivityFailure) {
                  // Show snackbar when there is no connection
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No internet connection'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  onTap: () {},
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
                        height: 16,
                      ),
                      const Text(
                        'Learn Your\nFavourite Agents',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          agentTextContr.text = value;
                        },
                        controller: agentTextContr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          labelText: 'Search Agent...',
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<AgentsBloc, AgentsState>(
                        buildWhen: (context, state) {
                          return state is AgentsLoadedState;
                        },
                        builder: (context, state) {
                          if (state is AgentsLoadedState) {
                            return SizedBox(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Color color = HexColor.fromHex(
                                      '#${state.data[index].backgroundGradientColors![1]}');
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () async {
                                          context.push('/detail',
                                              extra: state.data[index].uuid);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RotatedBox(
                                              quarterTurns: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  state
                                                      .data[index].displayName!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            if (state.data[index].role != null)
                                              RotatedBox(
                                                quarterTurns: 1,
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
                                            Expanded(
                                              child: Image.network(
                                                fit: BoxFit.cover,
                                                'https://media.valorant-api.com/agents/${state.data[index].uuid}/fullportrait.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // number of items in each row
                                  mainAxisSpacing: 8.0,
                                  // spacing between rows
                                  crossAxisSpacing:
                                      8.0, // spacing between columns
                                ),
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
          },
        ),
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
