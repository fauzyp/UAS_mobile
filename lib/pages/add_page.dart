import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleControler.text = title;
      descriptionControler.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Movie List' : 'Add Todo',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleControler,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descriptionControler,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    //ambil data dari form
    final todo = widget.todo;
    if (todo == null){
      // ignore: avoid_print
      print('You cant call updated without todo data');
      return;
    }
    final id = todo['_id'];
    final title = titleControler.text;
    final description = descriptionControler.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //submit update edit data ke server
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

        //status
    if (response.statusCode == 200) {
      showSuccessMessage('Update Success');
    } else {
      showErrorMessage('Update Failed');
    }
  }

  Future<void> submitData() async {
    //ambil data dari form
    final title = titleControler.text;
    final description = descriptionControler.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": true
    };

    //submit data ke server
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    //status
    if (response.statusCode == 201) {
      titleControler.text = '';
      descriptionControler.text = '';
      showSuccessMessage('Success');
    } else {
      showErrorMessage('Creation Failed');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
