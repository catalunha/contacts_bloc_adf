import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact_model.dart';
import '../repositories/contact_repository.dart';
import '../widgets/loader.dart';
import 'bloc/contact_addedit_bloc.dart';
import 'bloc/contact_addedit_event.dart';
import 'bloc/contact_addedit_state.dart';

class ContactAddEditPage extends StatelessWidget {
  final ContactModel? contactModel;
  const ContactAddEditPage({Key? key, required this.contactModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactAddEditBloc(
        contactRepository: context.read<ContactRepository>(),
        contactInitial: contactModel,
      ),
      child: ContactAddEditView(contactModel: contactModel),
    );
  }
}

class ContactAddEditView extends StatefulWidget {
  final ContactModel? contactModel;

  const ContactAddEditView({Key? key, required this.contactModel})
      : super(key: key);

  @override
  State<ContactAddEditView> createState() => _ContactAddEditViewState();
}

class _ContactAddEditViewState extends State<ContactAddEditView> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEC = TextEditingController();
  final _emailTEC = TextEditingController();

  @override
  void initState() {
    if (widget.contactModel != null) {
      _nameTEC.text = widget.contactModel?.name ?? '';
      _emailTEC.text = widget.contactModel!.email;
    }
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
    // final isNewContact = context.select(
    //     (ContactAddEditBloc contactAddEditBloc) =>
    //         contactAddEditBloc.state.isNewContact);
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<ContactAddEditBloc, ContactAddEditState, bool>(
          selector: (state) => state.isNewContact,
          builder: (context, isNewContact) =>
              Text(isNewContact ? 'Add' : 'Edit'),
        ),
      ),
      // appBar: AppBar(
      //   title: Text(widget.contactModel == null ? 'Add' : 'Edit'),
      // ),
      //       appBar: AppBar(
      //   title: Text(isNewContact ? 'Add' : 'Edit'),
      // ),
      body: BlocListener<ContactAddEditBloc, ContactAddEditState>(
        listenWhen: (previous, current) {
          return current.status == ContactAddEditStateStatus.success ||
              current.status == ContactAddEditStateStatus.error;
        },
        listener: (context, state) {
          if (state.status == ContactAddEditStateStatus.success) {
            Navigator.of(context).pop();
          }
          if (state.status == ContactAddEditStateStatus.error) {
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
                    context.read<ContactAddEditBloc>().add(
                          ContactAddEditEventSubmit(
                            name: _nameTEC.text,
                            email: _emailTEC.text,
                          ),
                        );
                  }
                },
                child: const Text('Enviar'),
              ),
              Loader<ContactAddEditBloc, ContactAddEditState>(
                  selector: (state) {
                return state.status == ContactAddEditStateStatus.loading;
              })
            ],
          ),
        ),
      ),
    );
  }
}
