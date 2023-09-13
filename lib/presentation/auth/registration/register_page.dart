import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(
                Icons.lock,
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full name',
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
                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: 'test@test.com', password: '123456');
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
