import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/agents/agents_bloc.dart';
import 'package:volarant_agents/application/app_manager/app_manager_cubit.dart';
import 'package:volarant_agents/application/auth/auth_bloc.dart';
import 'package:volarant_agents/application/connection_checker/connection_checker_bloc.dart';
import 'package:volarant_agents/application/home_page/home_page_cubit.dart';
import 'package:volarant_agents/application/user/user_bloc.dart';
import 'package:volarant_agents/firebase_options.dart';
import 'package:volarant_agents/infrastructure/services/shared_pref_service.dart';
import 'package:volarant_agents/presentation/home_page/agent_detail_info_page.dart';
import 'package:volarant_agents/presentation/home_page/home_page.dart';
import 'package:volarant_agents/presentation/pages/auth/login/login_page.dart';
import 'package:volarant_agents/presentation/pages/auth/registration/register_page.dart';
import 'package:volarant_agents/presentation/pages/splash_screen/splash_screen.dart';

import 'pages/auth/login/enter_display_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefService().init();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(
          create: (context) => AppManagerCubit(),
        ),
        BlocProvider(
          create: (context) => AgentsBloc(),
        ),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => ConnectionCheckerBloc())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/splash-screen',
  redirect: (context, state) async {
    SharedPrefService sharedPrefService = SharedPrefService();
    if (!await sharedPrefService.getLoginState()) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(
        name: '/splash-screen',
        path: '/splash-screen',
        builder: (context, state) => const SplashScreen()),
    GoRoute(
      name: '/home',
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: '/detail',
      path: '/detail',
      builder: (context, state) => AgentDetailInfoPage(
        agentId: state.extra as String,
      ),
    ),
    GoRoute(
      name: '/login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: '/register',
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: '/enter-display-name',
      path: '/enter-display-name',
      builder: (context, state) => const EnterDisplayName(),
    ),
  ],
);
