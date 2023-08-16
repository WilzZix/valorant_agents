import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/agents/agents_bloc.dart';
import 'package:volarant_agents/application/app_manager/app_manager_cubit.dart';
import 'package:volarant_agents/presentation/home_page/agent_detail_info_page.dart';
import 'package:volarant_agents/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppManagerCubit()..initApp(),
            ),
            BlocProvider(
              create: (context) => AgentsBloc()..add(GetAgentsEvent()),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: _router,
          ),
        );
      },
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => AgentDetailInfoPage(
        agentId: state.extra as String,
      ),
    ),
  ],
);
