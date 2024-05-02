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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D131A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D131A),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginInProgressState) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is LoggedInState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
          if (state is LoginErrorState) {
            isLoading = false;
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
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Or, register with email...',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                emailTextController.text = value;
              },
              controller: emailTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
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
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              onChanged: (value) {
                passwordTextController.text = value;
              },
              controller: passwordTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
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
                  if (!isLoading) {
                    BlocProvider.of<AuthBloc>(context).add(
                      LoginWithEmailAndPasswordEvent(
                        emailTextController.text,
                        passwordTextController.text,
                      ),
                    );
                  }
                },
                style: isLoading
                    ? ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0x4B1A5CC1),
                        ),
                      )
                    : ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF49F5DC),
                        ),
                      ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Sign in',
                        style: TextStyle(color: Colors.black),
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
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF49F5DC),
                  ),
                ),
                child: const Text(
                  'Create account',
                  style: TextStyle(color: Colors.black),
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
