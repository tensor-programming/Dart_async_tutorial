import 'dart:async';
import 'dart:io';
import 'dart:convert';

main() async {
  File file = File("test.txt");

  IOSink sink = file.openWrite(mode: FileMode.append);
  sink.add(utf8.encode("Hello from Dart at ${DateTime.now()}\n"));

  await sink.flush();
  await sink.close();

  Stream<List<int>> stream = file.openRead().asBroadcastStream();
  stream.transform(utf8.decoder).transform(LineSplitter()).listen(
        (String line) => print(line),
        onDone: () => print("Stream Closed"),
        onError: (e) => print(e.toString()),
      );

  stream.listen((byte) => print(byte.toList()));
}

// import 'dart:async';

// main() async {
//   // loadString("Hello, Async Dart").then(
//   //   (s) => print(s),
//   // );

//   // print(await number);

//   // String s = await loadString("Hello Dart Async");
//   // print(s);
//   // int x = await ((await addPartial(30))(60));
//   // print(x);

//   // Stream s = exampleStream(10);
//   // await for (var x in s) {
//   //   print("Number: $x\n");
//   // }

//   // exampleStream(10).listen((int i) => print("Number: $i"));

// }

// // Stream<int> exampleStream(int x) async* {
// //   for (int i = 0; i <= x; i++) {
// //     yield i;
// //   }
// // }

// // Future addPartial(int x) async => (int y) async => x + y;

// // Future<String> loadString(String str) {
// //   return Future.delayed(Duration(seconds: 1)).then((_) {
// //     return "String: $str";
// //   });
// // }

// // Future<int> get number {
// //   var x = 10;
// //   Duration duration = Duration(seconds: 1);
// //   Future delay = Future.delayed(duration);
// //   return delay.then((_) => x);
// // }

// // Future<String> loadString(String str) async {
// //   await Future.delayed(Duration(milliseconds: 300));
// //   return "String: $str";
// // }
