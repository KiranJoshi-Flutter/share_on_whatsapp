import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Share Texts & Files'),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            const urlImage =
                'https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg';

            final url = Uri.parse(urlImage);

            final response = await http.get(url);
            final bytes = response.bodyBytes;

            final temp = await getTemporaryDirectory();
            final path = '${temp.path}/image.jpg';
            File(path).writeAsBytesSync(bytes);

            await Share.shareFiles([path], text: 'This lion is cute');
          },
          child: const Text('Share Text'),
        ),
      ),
    );
  }
}
