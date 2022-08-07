
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Homepage.dart';
import 'package:todoapp/Providers/LoginProvider.dart';
import 'package:todoapp/Styles.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isSecured = true;
 bool isloggedIn = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height*0.1,
              ),
              Align(
                alignment: Alignment.topCenter,
                  child: Image.asset("assets/images/dartlogo.png",height:size.height*0.2,width:size.width*0.4,)),
            const  Center(child: Text('     Hey There, \nWelcome Back',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text('Email',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: TextFormField(
                        controller: _emailController,

                        decoration:  InputDecoration(
                          errorStyle: Styles.errorstyle,
                          border:const OutlineInputBorder(),

                          labelText: 'User Name',
                        ),
                        validator: (email) {
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = RegExp(pattern);
                          if (email!.isEmpty) {
                            return "Email can not be empty";
                          } else if (!regExp
                              .hasMatch(email)) {
                            return "Enter a valid email";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text('Password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration:  InputDecoration(
                          errorStyle: Styles.errorstyle,
                          border:const OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (password) {
                          if (password!.isEmpty) {
                            return "Password can not be empty";
                          } else if (password.length < 6) {
                            return "Passowrd should be atleast 6 letters";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    height: size.height*0.04,
                    width: size.width*0.4,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        getLogin(context);

                      },
                    )
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text('Forgot Password',),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  getLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Provider.of<LoginProvider>(context, listen: false)
          .getLogin(_emailController.text.toString(),
          _passwordController.text.toString())
          .then((value) {
        setState(() {
          isloggedIn = true;
          print("successfully logged in");
        });
        if (Provider.of<LoginProvider>(context, listen: false).success !=
            null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) =>const HomePage()),
                  (route) => false);
          print('navigated');
        //   toastmessage.sucesstoast(context, "You are loggined in Successfully");
         } else {
        //   toastmessage.warningmessage(
        //      context,
              Provider.of<LoginProvider>(context, listen: false)
                  .error
                  .toString();
         }
      });
    }
  }
}
