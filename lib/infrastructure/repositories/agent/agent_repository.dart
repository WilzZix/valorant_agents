import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:volarant_agents/domain/agents/i_agent.dart';
import 'package:volarant_agents/infrastructure/dto/agent_model.dart';
import 'package:volarant_agents/infrastructure/services/network_provider.dart';

class AgentsRepository implements IAgent {
  @override
  Future<List<AgentModel>> getAgents() async {
    log('line 9');
    final Response response =
        await NetworkProvider.dio.get('/agents');
    log('line 14');
    return AgentModel.fetchData(response.data ?? {});
  }

  @override
  Future<AgentModel> getAgentDetail({required String agentId}) async {
    final Response response = await NetworkProvider.dio
        .get('https://valorant-api.com/v1/agents/$agentId');
    return AgentModel.fromJson(response.data['data'] ?? {});
  }
}
