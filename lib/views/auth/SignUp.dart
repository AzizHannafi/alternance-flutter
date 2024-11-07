import 'package:alternance_flutter/views/auth/userstate/company_sign_up_state.dart';
import 'package:alternance_flutter/views/auth/userstate/student_sign_up_state.dart';
import 'package:alternance_flutter/views/auth/userstate/university_sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/custom/CheckboxC.dart';
import 'package:alternance_flutter/views/auth/SignIn.dart';
import 'package:alternance_flutter/views/auth/StudentSignUp.dart';
import 'package:alternance_flutter/views/auth/CompanySignUp.dart';
import 'package:alternance_flutter/views/auth/UniversitySignUp.dart';

import '../../model/user/RegisterDto.dart';
import '../../service/Auth/AuthService.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedOption;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UniversitySignUpState _universitySignUpState = UniversitySignUpState();
  final StudentSignUpState _studentSignUpState = StudentSignUpState();
  final CompanySignUpState _companySignUpState = CompanySignUpState();

  final AuthService _authService = AuthService();

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
                      controller: _emailController,
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
                      controller: _passwordController,
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
                    if (_selectedOption == "Student") ...[
                      StudentSignUp(key: UniqueKey(), state: _studentSignUpState),
                      _gap(),
                    ] else if (_selectedOption == "Company") ...[
                      CompanySignUp(key: UniqueKey(), state: _companySignUpState),
                      _gap(),
                    ] else if (_selectedOption == "University") ...[
                      UniversitySignUp(key: UniqueKey(), state: _universitySignUpState),
                      _gap(),
                    ],
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
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            RegisterDto registerDto;
                            switch (_selectedOption) {
                              case "University":
                                registerDto = RegisterDto(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  role: "university",
                                  universityName: _universitySignUpState.universityNameController.text,
                                  universityLocation: _universitySignUpState.locationController.text,
                                );
                                break;
                              case "Student":
                                registerDto = RegisterDto(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  role: "student",
                                  firstName: _studentSignUpState.firstNameController.text,
                                  lastName: _studentSignUpState.lastNameController.text,
                                  dateOfBirth: _studentSignUpState.dateOfBirth,
                                );
                                break;
                              case "Company":
                                registerDto = RegisterDto(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  role: "company",
                                  companyName: _companySignUpState.companyNameController.text,
                                  companyLocation: _companySignUpState.locationController.text,
                                  industry: _companySignUpState.industryController.text,
                                );
                                break;
                              default:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please select a role')),
                                );
                                return;
                            }

                            final result = await _authService.registerUser(registerDto);

                            if (result['success']) {
                              // Registration successful
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(result['message'])),
                              );
                              // Navigate to SignInPage or handle the successful registration
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ));
                            } else {
                              // Registration failed
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result['message']),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              print('Registration failed: ${result['message']}');
                            }
                          }
                        },
                      ),
                    ),

                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
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

  Widget _gap() => const SizedBox(height: 16);
}