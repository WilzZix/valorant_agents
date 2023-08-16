import 'package:volarant_agents/infrastructure/dto/agent_model.dart';

abstract class IAgent {
  const IAgent._();

  Future<List<AgentModel>> getAgents();

  Future<AgentModel> getAgentDetail({required String agentId});
}
