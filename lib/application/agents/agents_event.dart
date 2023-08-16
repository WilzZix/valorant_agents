part of 'agents_bloc.dart';

@immutable
abstract class AgentsEvent {}

class GetAgentsEvent extends AgentsEvent {}

class GetAgentDetailInfoEvent extends AgentsEvent {
  final String agentId;

  GetAgentDetailInfoEvent(this.agentId);
}
