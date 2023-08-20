import 'package:flutter/material.dart';
import 'package:mp_tictactoe/provider/room_data_provider.dart';
import 'package:mp_tictactoe/utils/socket_methods.dart';
import 'package:mp_tictactoe/views/scoreboard.dart';
import 'package:mp_tictactoe/views/tictactoe_board.dart';
import 'package:mp_tictactoe/views/waiting_lobby.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = "/game";
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomdataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
        body: roomdataProvider.roomData['isJoin']
            ? const WaitingLobby()
            :
            // ignore: prefer_const_constructors
            SafeArea(
                child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [const Scoreboard(), const TicTacToeBoard(),Text("${roomdataProvider.roomData['turn']['nickname']}\'s turn")],
              ),),);
  }
}
