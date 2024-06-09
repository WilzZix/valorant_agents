import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/dto/agent_model.dart';
import 'package:volarant_agents/infrastructure/repositories/agent/agent_repository.dart';

part 'agents_event.dart';

part 'agents_state.dart';

class AgentsBloc extends Bloc<AgentsEvent, AgentsState> {
  AgentsBloc() : super(AgentsInitial()) {
    on<GetAgentsEvent>(_getAgents);
    on<GetAgentDetailInfoEvent>(_getAgentDetail);
  }

  AgentsRepository repository = AgentsRepository();

  Future _getAgents(GetAgentsEvent event, Emitter<AgentsState> emitter) async {
    try {
      emit(AgentsLoadingState());
      List<AgentModel> data = await repository.getAgents();
      emit(AgentsLoadedState(data));
    } catch (e) {
      emit(AgentsLoadFailureState(e.toString()));
    }
  }

  Future _getAgentDetail(
      GetAgentDetailInfoEvent event, Emitter<AgentsState> emitter) async {
    emit(AgentDetailInfoLoadingState());
    try {
      AgentModel data = await repository.getAgentDetail(agentId: event.agentId);
      emit(AgentDetailDataLoadedState(data));
    } catch (e) {
      emit(AgentsDetailInfoLoadFailureState());
    }
  }
}
