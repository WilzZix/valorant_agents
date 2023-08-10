import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgentDetailInfoPage extends StatelessWidget {
  const AgentDetailInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        padding: const EdgeInsets.only(top: 100, left: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Omen',
                              style:
                                  TextStyle(fontSize: 42, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 32,
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF16163F),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: const Center(
                                  child: Text(
                                'Controller',
                                style: TextStyle(color: Colors.white54),
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl:
                          'https://media.valorant-api.com/agents/8e253930-4c05-31dd-1b6c-968525494517/fullportrait.png',
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              color: const Color(0xFF0C1217),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '// BIOGRAPHY',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'A phantom of a memory, Omen hunts in the shadows. He renders enemies blind, teleports across the field, then lets paranoia take hold as his foe scrambles to uncover where he might strike next.',
                        style: TextStyle(color: Colors.white38, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        '// SPECIAL ABILITIES',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AgentAbilityWidget(),
                      SizedBox(
                        height: 16,
                      ),
                      AgentAbilityWidget(),
                      SizedBox(
                        height: 16,
                      ),
                      AgentAbilityWidget(),
                      SizedBox(
                        height: 16,
                      ),
                      AgentAbilityWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgentAbilityWidget extends StatelessWidget {
  const AgentAbilityWidget({
    super.key,
  });

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
                  imageUrl:
                      'https://media.valorant-api.com/agents/8e253930-4c05-31dd-1b6c-968525494517/abilities/ability1/displayicon.png',
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PARANOIA',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'EQUIP a blinding orb.',
                  style: TextStyle(color: Colors.white38),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
