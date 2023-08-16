part of 'agents_bloc.dart';

@immutable
abstract class AgentsState {}

class AgentsInitial extends AgentsState {}

class AgentsLoadingState extends AgentsState {}

class AgentsLoadedState extends AgentsState {
  final List<AgentModel> data;

  AgentsLoadedState(this.data);
}

class AgentsLoadFailureState extends AgentsState {
  final String msg;

  AgentsLoadFailureState(this.msg);
}

/// Agents detail info

class AgentDetailInfoLoadingState extends AgentsState {}

class AgentDetailDataLoadedState extends AgentsState {
  final AgentModel data;

  AgentDetailDataLoadedState(this.data);
}

class AgentsDetailInfoLoadFailureState extends AgentsState {}
