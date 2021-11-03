import 'package:flutter/material.dart';
import 'package:flutter_for_dev_dm/ui/components/components.dart';
import 'package:flutter_for_dev_dm/ui/page/login/login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter? presenter;

  const LoginPage({Key? key, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter?.isLoadingController.listen((isLoading) {
            if (isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Aguarde...',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }
          });
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                TextHead1(
                  title: 'login',
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: StreamBuilder<String>(
                              stream: presenter?.emailErrorStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data,
                                    icon: Icon(
                                      Icons.email,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: presenter?.validateEmail,
                                );
                              }),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                              stream: presenter?.passwordErrorStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data,
                                    icon: Icon(
                                      Icons.lock,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  onChanged: presenter?.validatePassword,
                                  obscureText: true,
                                );
                              }),
                        ),
                        StreamBuilder<bool>(
                            stream: presenter?.isFormValidController,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.data == true
                                    ? presenter?.auth
                                    : null,
                                child: Text('Entrar'.toUpperCase()),
                              );
                            }),
                        FlatButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person),
                              Text('Criar conta'.toUpperCase())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
