import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:volarant_agents/application/auth/auth_bloc.dart';

class EnterDisplayName extends StatefulWidget {
  const EnterDisplayName({super.key});

  @override
  State<EnterDisplayName> createState() => _EnterDisplayNameState();
}

class _EnterDisplayNameState extends State<EnterDisplayName> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0D131A)),
      backgroundColor: const Color(0xFF0D131A),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserDisplayNameUpdated) {
            context.go('/home');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Enter display name',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: textEditingController,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    textEditingController.text = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    labelText: 'Enter display name',
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        UpdateUserNameEvent(textEditingController.text),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF49F5DC),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
