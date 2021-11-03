import 'package:flutter/material.dart';
import 'package:flutter_for_dev_dm/ui/components/components.dart';
import 'package:flutter_for_dev_dm/ui/page/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter? presenter;

  const LoginPage({Key? key, this.presenter}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget.presenter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter?.isLoadingController.listen(
            (isLoading) {
              if (isLoading) {
                showLoading(context);
              } else {
                hideLoading(context);
              }
            },
          );
          widget.presenter?.mainErrorController.listen((error) {
            if (error.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[900],
                  content: Text(
                    error,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
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
                              stream: widget.presenter?.emailErrorStream,
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
                                  onChanged: widget.presenter?.validateEmail,
                                );
                              }),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                              stream: widget.presenter?.passwordErrorStream,
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
                                  onChanged: widget.presenter?.validatePassword,
                                  obscureText: true,
                                );
                              }),
                        ),
                        StreamBuilder<bool>(
                            stream: widget.presenter?.isFormValidController,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.data == true
                                    ? widget.presenter?.auth
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
