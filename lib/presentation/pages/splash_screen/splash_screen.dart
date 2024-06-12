import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/app_manager/app_manager_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppManagerCubit>(context).initApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppManagerCubit, AppManagerState>(
        listener: (context, state) {
          if (state is AppManagerLoaded) {
            context.pushNamed('/home');
          }
          if (state is AppManagerLoadingError) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Center(
                  child: Text(state.msg),
                );
              },
            );
          }
        },
        child: const Center(
          child: Icon(Icons.downloading),
        ),
      ),
    );
  }
}
