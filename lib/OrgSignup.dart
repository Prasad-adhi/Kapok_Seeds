import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Firebase_auth_services.dart';
import 'Users.dart';

class OrgSignup extends StatefulWidget {
  @override
  _OrgSignupState createState() => _OrgSignupState();

}

class _OrgSignupState extends State<OrgSignup> {
  // Controller to retrieve the value of the TextField
  final TextEditingController _name_controller1 = TextEditingController();
  final TextEditingController _number_controller1 = TextEditingController();
  final TextEditingController _address_controller1 = TextEditingController();
  final TextEditingController _email_controller1 = TextEditingController();
  final TextEditingController _password_controller1 = TextEditingController();
  final TextEditingController _conf_password_controller1 = TextEditingController();
  bool _passwordVisible = false;
  bool _confpasswordvisible = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _numberFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confpasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus ) {
        _formKey.currentState?.validate();
      }
    });

    _numberFocusNode.addListener(() {
      if (!_numberFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _addressFocusNode.addListener(() {
      if (!_addressFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _confpasswordFocusNode.addListener(() {
      if (!_confpasswordFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Name';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Number';
    }
    final numberRegex = RegExp(r'^\+?[0-9]{1,3}?[-\s]?(\([0-9]{1,5}\))?[-\s]?[0-9]{3,4}[-\s]?[0-9]{3,4}[-\s]?[0-9]{3,4}$'
    );
    if(!numberRegex.hasMatch(value)){
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if(!passwordRegex.hasMatch(value)) {
      return 'Password must have a minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character';
    }
    return null;
  }

  String? _validateConfPassword(String? value) {
    if (value == null || value.isEmpty || value !=_password_controller1.text) {
      return 'Passwords do not match';
    }
    return null;
  }


  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      print('Name: ${_name_controller1.text}');
      print('Number: ${_number_controller1.text}');
      print('Address: ${_address_controller1.text}');
      print('Email: ${_email_controller1.text}');
      print('Password: ${_password_controller1.text}');
      print('Confirm password: ${_conf_password_controller1.text}');

      User? user = await _auth.signUpWithEmailAndPassword(_email_controller1.text, _password_controller1.text);

      if(user!=null)
        {
          print("User is Successfully created");
          // final firestore = FirebaseFirestore.instance;
          // await firestore.collection("Organizations").doc().set(
          //   {
          //     "Name": _address_controller1.text,
          //     "Number": _number_controller1.text,
          //     "Address": _address_controller1.text,
          //     "Email": _email_controller1.text,
          //     "Password": _password_controller1.text
          //   }
          // );

          _createData(OrganizationUserModel(
              name: _name_controller1.text,
              number:_number_controller1.text,
              address: _address_controller1.text,
              email: _email_controller1.text,
              password: _password_controller1.text
            )
          );
        }
      else{
        print("Some error occured");
      }
    }
  }

  String resultant_str = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Organization signup'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child:Column(
                children: <Widget>[
                  TextFormField(
                    controller: _name_controller1,
                    focusNode: _nameFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateName,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _number_controller1,
                    focusNode: _numberFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateNumber,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _address_controller1,
                    focusNode: _addressFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateAddress,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _email_controller1,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _password_controller1,
                    focusNode: _passwordFocusNode,
                    obscureText: !_passwordVisible, // Hide the password
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _conf_password_controller1,
                    focusNode: _confpasswordFocusNode,
                    obscureText: !_confpasswordvisible, // Hide the password
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confpasswordvisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _confpasswordvisible = !_confpasswordvisible;
                          });
                        },
                      ),
                    ),
                    validator: _validateConfPassword,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:_submitForm,
                    child: Text('Sign up'),
                  ),
                  SizedBox(height: 20),
                  Text(resultant_str),
                ],
              ),
            )
        )
    );
  }

  @override
  void dispose() {
    _name_controller1.dispose();
    _number_controller1.dispose();
    _address_controller1.dispose();
    _email_controller1.dispose();
    _password_controller1.dispose();
    _conf_password_controller1.dispose();

    super.dispose();
  }
}

void _createData(OrganizationUserModel orgusermodel){
  final userCollection = FirebaseFirestore.instance.collection("Organizations");
  String id = userCollection.doc().id;

  final newUser = OrganizationUserModel(
      name: orgusermodel.name,
      number: orgusermodel.number,
      address: orgusermodel.address,
      email: orgusermodel.email,
      password: orgusermodel.password,
      id: id
  ).toJson();


  userCollection.doc(id).set(newUser);
}