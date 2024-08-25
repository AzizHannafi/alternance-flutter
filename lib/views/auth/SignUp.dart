import 'package:flutter/material.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/custom/CheckboxC.dart';
import 'package:alternance_flutter/views/auth/SignIn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.primaryWhite,
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/alternance_logo.png"),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Thank you for joining us",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsUtils.primaryGreen))),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsUtils.primaryGreen)),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          )),
                    ),
                    _gap(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkboxc(
                            imagePth: "assets/university.svg",
                            text: const Text("University"),
                            isSelected: _selectedOption == "University",
                            onSelected: () {
                              setState(() {
                                _selectedOption = "University";
                              });
                            },
                          ),
                          Checkboxc(
                            imagePth: "assets/student.svg",
                            text: const Text("Student"),
                            isSelected: _selectedOption == "Student",
                            onSelected: () {
                              setState(() {
                                _selectedOption = "Student";
                              });
                            },
                          ),
                          Checkboxc(
                            imagePth: "assets/company.svg",
                            text: const Text("Company"),
                            isSelected: _selectedOption == "Company",
                            onSelected: () {
                              setState(() {
                                _selectedOption = "Company";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    _gap(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            backgroundColor: ColorsUtils.primaryBleu),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Perform signup action here
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account ?"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const SignInPage(),
                                ));
                              },
                              child: const Text(
                                "Sign in!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsUtils.primaryGreen),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 30);
}
