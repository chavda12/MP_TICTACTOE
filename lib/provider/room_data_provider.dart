import 'package:flutter/material.dart';
import 'package:mp_tictactoe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
 final List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  Player _player1 =
      Player(nickname: '', playerType: 'X', points: 0, socketID: '');

  Player _player2 =
      Player(nickname: '', playerType: '0', points: 0, socketID: '');

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void setFilledBoxesTo0() {
    _filledBoxes = 0;
  }
}
