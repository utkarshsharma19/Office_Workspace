import 'package:flutter/material.dart';

class SelectUsersChip extends StatefulWidget {
  // List<String> users;

  Function(List<String> userlist) onUsersSelected;

  SelectUsersChip({
    // required this.users,

    required this.onUsersSelected,
  });

  @override
  _SelectUsersChipState createState() => _SelectUsersChipState();
}

class _SelectUsersChipState extends State<SelectUsersChip> {
  List<String> emails = [];

  TextEditingController _emailController = TextEditingController();

  void addEmail() {
    setState(() {
      final email = _emailController.text.trim();

      if (email.isNotEmpty && !_isEmailExists(email)) {
        emails.add(email);

        widget.onUsersSelected(emails);

        // widget.users.add(email);

        _emailController.clear();
      }
    });
  }

  bool _isEmailExists(String email) {
    return emails.contains(email);
  }

  void removeEmail(String email) {
    setState(() {
      emails.remove(email);

      widget.onUsersSelected(emails);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 2.0,
          children: List<Widget>.generate(
            emails.length,
            (int index) {
              return InputChip(
                label: Text(emails[index]),
                avatar: Icon(Icons.person),
                onDeleted: () {
                  removeEmail(emails[index]);
                },
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  onFieldSubmitted: (value) {
                    addEmail();
                  },
                  decoration: InputDecoration(
                      labelText: 'Users', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                  onPressed: addEmail,
                  child: Text(
                    'ADD',
                    style: TextStyle(color: Colors.yellow[900]),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
