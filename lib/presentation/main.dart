import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/agents/agents_bloc.dart';
import 'package:volarant_agents/application/app_manager/app_manager_cubit.dart';
import 'package:volarant_agents/firebase_options.dart';
import 'package:volarant_agents/presentation/auth/registration/register_page.dart';
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
    initializeFirebase();
    super.initState();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
          ),
        );
      },
    );
  }
}

final _router = GoRouter(
  initialLocation: '/register',
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
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
