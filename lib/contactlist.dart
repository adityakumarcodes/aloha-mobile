import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionAndLoadContacts();
  }

  Future<void> _checkPermissionAndLoadContacts() async {
    final status = await Permission.contacts.status;

    if (status.isGranted) {
      _loadContacts();
    } else {
      final result = await Permission.contacts.request();
      if (result.isGranted) {
        _loadContacts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contact permission denied')),
        );
      }
    }
  }

  Future<void> _loadContacts() async {
    final contacts = await ContactsService.getContacts(withThumbnails: false);
    setState(() => _contacts = contacts.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: _contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return ListTile(
                  title: Text(contact.displayName ?? 'No Name'),
                  subtitle: contact.phones != null && contact.phones!.isNotEmpty
                      ? Text(contact.phones!.first.value ?? '')
                      : const Text('No number'),
                );
              },
            ),
    );
  }
}
