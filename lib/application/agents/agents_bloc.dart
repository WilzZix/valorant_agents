import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/dto/agent_model.dart';
import 'package:volarant_agents/infrastructure/repositories/agent/agent_repository.dart';

part 'agents_event.dart';

part 'agents_state.dart';

class AgentsBloc extends Bloc<AgentsEvent, AgentsState> {
  AgentsBloc() : super(AgentsInitial()) {
    on<GetAgentsEvent>(_getAgents);
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
}
