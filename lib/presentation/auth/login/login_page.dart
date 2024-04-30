import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/auth/auth_bloc.dart';
import 'package:volarant_agents/presentation/home_page/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoggedInState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
          if (state is LoginErrorState) {
            showBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text(state.msg),
                    ),
                  );
                });
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Sign in',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SignInMethodWidget(
                  path: 'assets/google.png',
                ),
                SignInMethodWidget(
                  path: 'assets/apple.png',
                ),
                SignInMethodWidget(
                  path: 'assets/facebook.png',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Or, register with email...',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              onChanged: (value) {
                emailTextController.text = value;
              },
              controller: emailTextController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.mail,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              onChanged: (value) {
                passwordTextController.text = value;
              },
              controller: passwordTextController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(
                  Icons.lock,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                onPressed: () {
                  log('line 92');
                  BlocProvider.of<AuthBloc>(context).add(
                      LoginWithEmailAndPasswordEvent(emailTextController.text,
                          passwordTextController.text));
                  log('line 99');
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
                child: const Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                onPressed: () {
                  context.go('/register');
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
                child: const Text(
                  'Create account',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class SignInMethodWidget extends StatelessWidget {
  const SignInMethodWidget({
    Key? key,
    required this.path,
  }) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
      height: 60,
      width: 60,
      child: Image.asset(
        path,
        width: 20,
        height: 20,
      ),
    );
  }
}
