import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/model/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    required this.onSubmit,
    super.key,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError("Imagen não selecionada");
    }
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(onImagePick: _handleImagePick),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey("name"),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(hintText: 'Nome'),
                  validator: (_name) {
                    final name = _name ?? "";
                    if (name.trim().length < 3) {
                      return "Nome deve ter no minimo 3 caracteres";
                    }
                    return null;
                  },
                ),
              TextFormField(
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                key: const ValueKey("email"),
                decoration: const InputDecoration(hintText: 'E-mail'),
                validator: (_email) {
                  final email = _email ?? "";
                  if (!email.contains("@")) {
                    return "E-mail informado é invalido";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                key: const ValueKey("password"),
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Senha'),
                validator: (_password) {
                  final password = _password ?? "";
                  if (password.length < 6) {
                    return "Senha deve ter no minimo 6 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _submit,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    _formData.isLogin ? "Entrar" : "Entrar",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                child: Text(_formData.isLogin
                    ? "Criar uma nova conta?"
                    : "Já possui conta?"),
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
