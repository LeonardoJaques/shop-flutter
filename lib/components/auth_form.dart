import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/auth.dart';

enum AuthMode { signUp, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final Map<String, String> _authData = {'email': '', 'password': ''};
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.login;
  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignUp() => _authMode == AuthMode.signUp;
  bool _isLoading = false;

  void _switchAuthMode() {
    setState(() {
      if (_isSignUp()) {
        _authMode = AuthMode.login;
      } else {
        _authMode = AuthMode.signUp;
      }
    });
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    if (_isLogin()) {
      // Login
      await auth.login(
        _authData['email']!,
        _authData['password']!,
      );
    } else {
      // Registrar
      await auth.signUp(
        _authData['email']!,
        _authData['password']!,
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (emailValue) {
                    final email = emailValue ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Informe um email válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  validator: _isLogin()
                      ? null
                      : (passwordValue) {
                          final password = passwordValue ?? '';
                          if (password.isEmpty || password.length < 5) {
                            return 'Informe uma senha válida';
                          }
                          return null;
                        },
                  onSaved: (password) => _authData['password'] = password ?? '',
                ),
                if (_isSignUp())
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirmar Senha'),
                    obscureText: true,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (passwordValue) {
                      final password = passwordValue ?? '';
                      if (password != _passwordController.text) {
                        return 'Senhas são diferentes';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          _isLogin() ? 'Entrar' : 'Cadastrar',
                        ),
                      ),
                const Spacer(),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(_isSignUp() ? 'Já possui conta?' : 'Criar conta'),
                ),
              ],
            )),
      ),
    );
  }
}
