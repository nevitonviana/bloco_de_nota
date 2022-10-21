import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/notifier/default_listener_notifier.dart';
import '../../core/widget/todo_list_field.dart';
import '/core/ui/theme_extensions.dart';
import 'task_create_controller.dart';
import 'widget/calendar_button.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  const TaskCreatePage({Key? key, required TaskCreateController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _descriptionEc = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(
      changeNotifier: widget._controller,
    ).listener(
      context: context,
      successVoidCallback: (notifier, listenerNotifier) {
        listenerNotifier.dispose();
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    _descriptionEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        onPressed: () {
          final formVald = _formKey.currentState?.validate() ?? false;
          if (formVald) {
            widget._controller.save(_descriptionEc.text);
          }
        },
        label: const Text(
          "Salvar Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Criar Atividade",
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
              TodoListField(
                controller: _descriptionEc,
                validator: Validatorless.required("Descrição é obrigatorio"),
                label: '',
              ),
              const SizedBox(height: 20),
              CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
