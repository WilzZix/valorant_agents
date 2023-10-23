import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volarant_agents/application/user/user_bloc.dart';
import 'package:volarant_agents/presentation/auth/login/login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserCreatedState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
          if (state is UserCreateFailureState) {
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
            Image.asset(
              'assets/register.jpg',
              height: 400,
              width: 400,
            ),
            const Text(
              'Sign up',
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
                  BlocProvider.of<UserBloc>(context)
                      .add(CreateUserEvent(emailTextController.text, passwordTextController.text));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
                child: const Text(
                  'Sign up',
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
