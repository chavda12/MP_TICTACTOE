import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  late IO.Socket socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = IO.io(
      'ws://localhost:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .build(),
    );
    socket.onConnect((_) {
     print('connect $_');
     socket.emit('msg', 'test');
    });

    socket.on("hey", (data) => print(data));
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
