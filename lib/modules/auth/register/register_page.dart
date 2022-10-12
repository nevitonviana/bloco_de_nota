import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/validators/validators.dart';
import '../../../core/widget/todo_list_field.dart';
import '../../../core/widget/todo_list_logo.dart';
import '/core/ui/theme_extensions.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();



  @override
  void initState() {
    super.initState();
    final controller = context.read<RegisterController>();
    context.read<RegisterController>().addListener(() {
      var success = controller.success;
      var error = controller.error;
      if (success) {
        Navigator.of(context).pop();
      } else if (error != null && error.isNotEmpty) {

      }
    });

  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
    context.read<RegisterController>().removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Todo List",
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            Text(
              "Cadastro",
              style: TextStyle(fontSize: 15, color: context.primaryColor),
            )
          ],
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: context.primaryColor.withAlpha(20),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    controller: _emailEC,
                    label: 'E-mail',
                    validator: Validatorless.multiple([
                      Validatorless.required("E-mail obrigatori"),
                      Validatorless.email("E-mail invalid"),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    controller: _passwordEC,
                    label: 'Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required("Senha obrigatoria"),
                      Validatorless.min(
                          6, "senha deve ter pelo menos 6 caracteres")
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    controller: _confirmPasswordEC,
                    label: 'Confirma Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required("Senha obrigatoria"),
                      Validators.compare(
                          _passwordEC, "senha diferente de confirmação"),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          context
                              .read<RegisterController>()
                              .registerUser(_emailEC.text, _passwordEC.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Salvar"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
