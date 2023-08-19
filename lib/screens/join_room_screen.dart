import 'package:flutter/material.dart';
import 'package:mp_tictactoe/customWidgets/custom_button.dart';
import 'package:mp_tictactoe/customWidgets/custom_text.dart';
import 'package:mp_tictactoe/customWidgets/custom_textFields.dart';
import 'package:mp_tictactoe/responsive/responsive.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                shadows: const [Shadow(blurRadius: 40, color: Colors.blue)],
                text: 'Create Room',
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                  controller: _nameController, hintText: 'Enter your nickname'),
              SizedBox(height: 20),
              CustomTextField(
                  controller: _gameIdController, hintText: 'Enter Game Id'),
              SizedBox(height: size.height * 0.045),
              CustomButton(onTap: () {}, text: 'Create')
            ],
          ),
        ),
      ),
    );
  }
}
