import 'package:contacts_bloc_adf/contacts/add/bloc/contact_add_event.dart';
import 'package:contacts_bloc_adf/contacts/add/bloc/contact_add_state.dart';
import 'package:contacts_bloc_adf/contacts/repositories/contact_repository.dart';
import 'package:contacts_bloc_adf/contacts/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contact_add_bloc.dart';

class ContactAddPage extends StatelessWidget {
  const ContactAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ContactAddBloc(contactRepository: context.read<ContactRepository>()),
      child: const ContactAddView(),
    );
  }
}

class ContactAddView extends StatefulWidget {
  const ContactAddView({Key? key}) : super(key: key);

  @override
  State<ContactAddView> createState() => _ContactAddViewState();
}

class _ContactAddViewState extends State<ContactAddView> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEC = TextEditingController();
  final _emailTEC = TextEditingController();

  @override
  void dispose() {
    _nameTEC.dispose();
    _emailTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: BlocListener<ContactAddBloc, ContactAddState>(
        listenWhen: (previous, current) {
          return current.status == ContactAddStateStatus.success ||
              current.status == ContactAddStateStatus.error;
        },
        listener: (context, state) {
          if (state.status == ContactAddStateStatus.success) {
            Navigator.of(context).pop();
          }
          if (state.status == ContactAddStateStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameTEC,
                decoration: const InputDecoration(label: Text('name')),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailTEC,
                decoration: const InputDecoration(label: Text('email')),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Email é obrigatório';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final validate = _formKey.currentState?.validate() ?? false;
                  if (validate) {
                    context.read<ContactAddBloc>().add(
                          ContactAddEventSubmit(
                            name: _nameTEC.text,
                            email: _emailTEC.text,
                          ),
                        );
                  }
                },
                child: const Text('Enviar'),
              ),
              Loader<ContactAddBloc, ContactAddState>(selector: (state) {
                return state.status == ContactAddStateStatus.loading;
              })
            ],
          ),
        ),
      ),
    );
  }
}
