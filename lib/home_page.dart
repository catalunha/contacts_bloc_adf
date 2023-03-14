import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/example');
              },
              child: const Text('Example'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/example2');
              },
              child: const Text('Example 2'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/contact');
              },
              child: const Text('Contact List'),
            )
          ],
        ),
      ),
    );
  }
}
