import 'package:contacts_bloc_adf/contacts/list/contact_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts/add/contact_add_page.dart';
import 'contacts/addedit/contact_addedit_page.dart';
import 'contacts/edit/contact_edit_page.dart';
import 'contacts/models/contact_model.dart';
import 'contacts/repositories/contact_repository.dart';
import 'example/example_page.dart';
import 'example2/example2_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactRepository(),
      child: MaterialApp(
        title: 'Contacts Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (_) => const HomePage(),
          '/example': (_) => const ExamplePage(),
          '/example2': (_) => const Example2Page(),
          '/contact': (_) => const ContactListPage(),
          '/contact/add': (_) => const ContactAddPage(),
          '/contact/edit': (context) {
            final contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel;
            return ContactEditPage(contactModel: contact);
          },
          '/contact/addedit': (context) {
            ContactModel? contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel?;
            return ContactAddEditPage(contactModel: contact);
          },
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
      ),
    );
  }
}
