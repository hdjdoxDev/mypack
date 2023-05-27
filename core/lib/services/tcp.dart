
  // void sendDataToServer() async {
  //   final host = "10.80.33.54";
  //   final port = 53550;
  //   TcpSocketConnection s = TcpSocketConnection(host, port);
  //   List<String> msgs = <String>[];
  //   for (var entry in data.map.values) {
  //     if (entry != null && entry.laydown != null && entry.wakeup != null) {
  //       msgs.add(
  //           "ADD${entry.date.year};${entry.date.month};${entry.date.day};${entry.laydown!.hour};${entry.laydown!.minute};${entry.wakeup!.hour};${entry.wakeup!.minute}");
  //     }
  //   }
  //   print("hello :)");
  //   await s.connect(5000, (data) => {print("data: $data")});
  //   if (s.isConnected()) {
  //     for (var msg in msgs) {
  //       var len = msg.length;
  //       if (len > 99 || len < 1) {
  //         continue;
  //       } else if (len > 9) {
  //         s.sendMessage("$len$msg");
  //         print("$len$msg");
  //       } else {
  //         s.sendMessage("0$len$msg");
  //         print("0$len$msg");
  //       }
  //     }
  //   }
  //   s.disconnect();
  // }