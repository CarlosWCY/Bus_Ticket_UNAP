import 'package:bt_unap/constants/routes.dart';
import 'package:bt_unap/utilities/show_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Bus Ticket UNAP'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
                
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Ingrese su Email',
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Ingrese su Password',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                        
                      final email = _email.text;
                      final password = _password.text;
                      try{
                        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email, 
                        password: password,
                        );
                        devtools.log(userCredential.toString());
                        final user = FirebaseAuth.instance.currentUser;
                        if (user?.emailVerified ?? false){
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            controllerRoute, 
                            (route) => false,
                          );
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            verifyEmailRoute, 
                            (route) => false,
                          );
                        }
                        
                      } on FirebaseAuthException catch (e){
                        if(e.code == 'user-not-found'){
                          await showErrorDialog(context, 'User not found',);
                        }else if(e.code == 'wrong-password'){
                          await showErrorDialog(context, 'Wrong credentials',);
                        }else{
                          await showErrorDialog(context, 'Error: ${e.code}',);
                        }
                      } catch(e){
                        await showErrorDialog(context, e.toString(),);
                      }                  
                    },
                    child: const Text('Login'),
            
                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute, 
                      (route) => false,
                    );
                  }, 
                  child: const Text('¿No esta registrado aún?, Registrese aquí!')
                  )
          ],
        ),
      ),
    );
  }
}

