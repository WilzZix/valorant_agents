import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volarant_agents/application/agents/agents_bloc.dart';

class AgentDetailInfoPage extends StatefulWidget {
  const AgentDetailInfoPage({super.key, required this.agentId});

  final String agentId;

  @override
  State<AgentDetailInfoPage> createState() => _AgentDetailInfoPageState();
}

class _AgentDetailInfoPageState extends State<AgentDetailInfoPage> {
  @override
  void initState() {
    BlocProvider.of<AgentsBloc>(context)
        .add(GetAgentDetailInfoEvent(widget.agentId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AgentsBloc, AgentsState>(
        builder: (context, state) {
          if (state is AgentDetailInfoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AgentDetailDataLoadedState) {

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xFF38377F),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 100.h, left: 16.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    state.data.displayName!,
                                    style: TextStyle(
                                        fontSize: 42.sp, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Container(
                                    height: 32.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF16163F),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.r))),
                                    child: Center(
                                      child: Text(
                                        state.data.role!.displayName!,
                                        style: const TextStyle(
                                            color: Colors.white54),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: state.data.fullPortrait! ?? '',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: const Color(0xFF0C1217),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.h, vertical: 16.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '// BIOGRAPHY',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              returnStringTillFirstDot(state.data.description!),
                              style: const TextStyle(
                                  color: Colors.white38, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              '// SPECIAL ABILITIES',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AgentAbilityWidget(
                              title: state.data.abilities![0].displayName!,
                              description:
                                  state.data.abilities![0].description!,
                              imageUrl: state.data.abilities![0].displayIcon!,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AgentAbilityWidget(
                              title: state.data.abilities![1].displayName!,
                              description:
                                  state.data.abilities![1].description!,
                              imageUrl: state.data.abilities![1].displayIcon!,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AgentAbilityWidget(
                              title: state.data.abilities![2].displayName!,
                              description:
                                  state.data.abilities![2].description!,
                              imageUrl: state.data.abilities![2].displayIcon!,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AgentAbilityWidget(
                              title: state.data.abilities![3].displayName!,
                              description:
                                  state.data.abilities![3].description!,
                              imageUrl: state.data.abilities![3].displayIcon!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

String returnStringTillFirstDot(String data) {
  String result = '';
  int space = data.indexOf('.');
  result = data.substring(0, space + 1);
  return result;
}

class AgentAbilityWidget extends StatelessWidget {
  const AgentAbilityWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xFF111923),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF15202F),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  softWrap: true,
                  returnStringTillFirstDot(description),
                  style: const TextStyle(color: Colors.white38),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
