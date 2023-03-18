import 'package:contacts_bloc_adf/contacts/list/bloc/contact_list_event.dart';
import 'package:contacts_bloc_adf/contacts/list/bloc/contact_list_state.dart';
import 'package:contacts_bloc_adf/contacts/repositories/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/loader.dart';
import 'bloc/contact_list_bloc.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ContactListBloc(contactRepository: context.read<ContactRepository>())
            ..add(ContactListEventFindAll()),
      child: const ContactListView(),
    );
  }
}

class ContactListView extends StatelessWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var blocTemp = context.read<ContactListBloc>();
          // await Navigator.pushNamed(context, '/contact/add');
          await Navigator.pushNamed(context, '/contact/addedit');
          // if (!context.mounted) return;
          blocTemp.add(ContactListEventFindAll());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ContactListBloc, ContactListState>(
        listenWhen: (previous, current) {
          return current.status == ContactListStateStatus.error;
        },
        listener: (context, state) {
          print('BlocListener...................');
          if (state.status == ContactListStateStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: RefreshIndicator(
          onRefresh: () async =>
              context.read<ContactListBloc>().add(ContactListEventFindAll()),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Loader<ContactListBloc, ContactListState>(
                      selector: (state) {
                        if (state.status == ContactListStateStatus.loading) {
                          return true;
                        }
                        return false;
                      },
                    ),
                    BlocBuilder<ContactListBloc, ContactListState>(
                      builder: (context, state) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.contacts.length,
                          itemBuilder: (_, index) {
                            var contact = state.contacts[index];
                            return ListTile(
                              title: Text(contact.name ?? "..."),
                              subtitle: Text('${contact.id}'),
                              onLongPress: () {
                                context.read<ContactListBloc>().add(
                                    ContactListEventDelete(id: contact.id!));
                              },
                              onTap: () async {
                                var blocTemp = context.read<ContactListBloc>();
                                await Navigator.pushNamed(
                                  context,
                                  '/contact/edit',
                                  arguments: contact,
                                );
                                // await Navigator.pushNamed(
                                //   context,
                                //   '/contact/addedit',
                                //   arguments: contact,
                                // );
                                blocTemp.add(ContactListEventFindAll());
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
