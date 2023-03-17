import 'package:dio/dio.dart';

import '../models/contact_model.dart';

class ContactRepository {
  Future<List<ContactModel>> findAll() async {
    try {
      final response = await Dio().get('http://192.168.10.113:3031/contacts');
      await Future.delayed(const Duration(seconds: 2));
      return response.data
          ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
          .toList();
    } catch (e) {
      print('Erro em DIO.....');
      print(e);
      return [];
    }
  }

  Future<void> create(ContactModel contact) async {
    await Future.delayed(const Duration(seconds: 2));

    await Dio()
        .post('http://192.168.10.113:3031/contacts', data: contact.toMap());
  }

  Future<void> update(ContactModel contact) async {
    await Future.delayed(const Duration(seconds: 2));

    await Dio().put('http://192.168.10.113:3031/contacts/${contact.id}',
        data: contact.toMap());
  }

  Future<void> delete(int contactId) async {
    await Future.delayed(const Duration(seconds: 2));

    await Dio().delete('http://192.168.10.113:3031/contacts/$contactId');
  }
}
