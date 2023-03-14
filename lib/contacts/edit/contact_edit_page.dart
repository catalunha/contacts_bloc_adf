import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact_model.dart';
import '../repositories/contact_repository.dart';
import '../widgets/loader.dart';
import 'bloc/contact_edit_bloc.dart';
import 'bloc/contact_edit_event.dart';
import 'bloc/contact_edit_state.dart';

class ContactEditPage extends StatelessWidget {
  final ContactModel contactModel;
  const ContactEditPage({Key? key, required this.contactModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ContactEditBloc(contactRepository: context.read<ContactRepository>()),
      child: ContactEditView(contactModel: contactModel),
    );
  }
}

class ContactEditView extends StatefulWidget {
  final ContactModel contactModel;

  const ContactEditView({Key? key, required this.contactModel})
      : super(key: key);

  @override
  State<ContactEditView> createState() => _ContactEditViewState();
}

class _ContactEditViewState extends State<ContactEditView> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEC = TextEditingController();
  final _emailTEC = TextEditingController();

  @override
  void initState() {
    _nameTEC.text = widget.contactModel.name;
    _emailTEC.text = widget.contactModel.email;
    super.initState();
  }

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
        title: const Text('Edit'),
      ),
      body: BlocListener<ContactEditBloc, ContactEditState>(
        listenWhen: (previous, current) {
          return current.status == ContactEditStateStatus.success ||
              current.status == ContactEditStateStatus.error;
        },
        listener: (context, state) {
          if (state.status == ContactEditStateStatus.success) {
            Navigator.of(context).pop();
          }
          if (state.status == ContactEditStateStatus.error) {
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
                    context.read<ContactEditBloc>().add(
                          ContactEditEventSubmit(
                            id: widget.contactModel.id,
                            name: _nameTEC.text,
                            email: _emailTEC.text,
                          ),
                        );
                  }
                },
                child: const Text('Enviar'),
              ),
              Loader<ContactEditBloc, ContactEditState>(selector: (state) {
                return state.status == ContactEditStateStatus.loading;
              })
            ],
          ),
        ),
      ),
    );
  }
}
