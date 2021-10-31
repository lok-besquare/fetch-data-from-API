import 'dart:convert';
import 'package:web_socket_channel/io.dart';

void main(List<String> arguments) {
  //
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');
  channel.stream.listen((message) {
    //format
    final decodedMessage = jsonDecode(message);
    final getSymbol = decodedMessage['tick']['symbol'];
    final getPrice = decodedMessage['tick']['quote'];
    final serverTimeAsEpoch = decodedMessage['tick']['epoch'];
    final serverTime =
        DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);
    print('Name: $getSymbol Price: $getPrice Time: $serverTime');
  });
  channel.sink.add('{"ticks": "R_50","subscribe": 1}');
}
