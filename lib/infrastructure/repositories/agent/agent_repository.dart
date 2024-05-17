import 'package:dio/dio.dart';
import 'package:volarant_agents/domain/agents/i_agent.dart';
import 'package:volarant_agents/infrastructure/dto/agent_model.dart';

class AgentsRepository implements IAgent {
  Dio dio = Dio();

  @override
  Future<List<AgentModel>> getAgents() async {
    final Response response =
        await dio.get('https://valorant-api.com/v1/agents/');
    return AgentModel.fetchData(response.data ?? {});
  }

  @override
  Future<AgentModel> getAgentDetail({required String agentId}) async {
    final Response response =
        await dio.get('https://valorant-api.com/v1/agents/$agentId');
    return AgentModel.fromJson(response.data['data'] ?? {});
  }
}
