import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:volarant_agents/domain/agents/i_agent.dart';
import 'package:volarant_agents/infrastructure/dto/agent_model.dart';

class AgentsRepository implements IAgent {
  Dio dio = Dio();

  @override
  Future<List<AgentModel>> getAgents() async {
    log('line 9');
    final Response response =
        await dio.get('https://valorant-api.com/v1/agents/');
    log('line 14');
    return AgentModel.fetchData(response.data ?? {});
  }

  @override
  Future<AgentModel> getAgentDetail({required String agentId}) async {
    log('line 222');
    final Response response =
        await dio.get('https://valorant-api.com/v1/agents/$agentId');
    log('line 255');
    return AgentModel.fromJson(response.data['data'] ?? {});
  }
}
