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
                'Choose your Favourite Agents',
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
                    title: 'Agents',
                    checked: true,
                  ),
                  TabItem(
                    title: 'Maps',
                    checked: false,
                  ),
                  TabItem(
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
                      height: MediaQuery.of(context).size.height * .45,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * .4,
                            width: MediaQuery.of(context).size.width * .7,
                            child: GestureDetector(
                              onTap: () async {
                                context.push('/detail',
                                    extra: state.data[index].uuid);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    height:
                                        MediaQuery.of(context).size.height * .35,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://media.valorant-api.com/agents/${state.data[index].uuid}/fullportrait.png',
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
                                  Container(
                                    height: 3,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey,
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
                              ),
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
