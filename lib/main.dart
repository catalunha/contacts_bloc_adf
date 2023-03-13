import 'package:flutter/material.dart';

import 'example/example_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (_) => const HomePage(),
        '/example': (_) => const ExamplePage(),
        // '/example': (_) => RepositoryProvider(
        //       create: (context) => ExampleRepository(),
        //       child: const ExamplePage(),
        //     ),
        // '/example': (_) => RepositoryProvider(
        //       create: (context) => ExampleRepository(),
        //       child: BlocProvider(
        //         create: (_) => ExampleBloc(
        //           exampleRepository:
        //               RepositoryProvider.of<ExampleRepository>(_),
        //         ),
        //         child: const ExamplePage(),
        //       ),
        //     ),
      },
    );
  }
}
