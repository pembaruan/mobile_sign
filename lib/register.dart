import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quickalert/quickalert.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _kelaminController = TextEditingController();
  final TextEditingController _tanggal_lahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _register() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': _fullnameController.text,
        'username': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'kelamin': _kelaminController.text,
        'tanggal_lahir': _tanggal_lahirController.text,
        'alamat': _alamatController.text,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // Handle successful registration
      print('Register successful');
      _showQuickAlert(
        context,
        'Success',
        'Registration successful',
        QuickAlertType.success,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      // Handle error or unsuccessful registration
      print('Register failed');
      _showQuickAlert(
        context,
        'Error',
        'Registration failed',
        QuickAlertType.error,
      );
    }
  }

  void _showQuickAlert(
      BuildContext context, String title, String message, QuickAlertType type) {
    QuickAlert.show(
      context: context,
      type: type,
      title: title,
      text: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'assets/polije.png',
                          width: 200,
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        width: 350, // Atur lebar sesuai kebutuhan
                        child: _buildTextFormField(
                          controller: _fullnameController,
                          labelText: 'Fullname',
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your fullname';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 350, // Atur lebar sesuai kebutuhan
                        child: _buildTextFormField(
                          controller: _usernameController,
                          labelText: 'Username',
                          icon: Icons.people,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Username';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 350, // Atur lebar sesuai kebutuhan
                        child: _buildTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 350, // Atur lebar sesuai kebutuhan
                        child: _buildTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          icon: Icons.lock,
                          obscureText: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        child: DropdownButtonFormField<String>(
                          value: _kelaminController.text.isEmpty
                              ? null
                              : _kelaminController.text,
                          decoration: InputDecoration(
                            labelText: 'Jenis Kelamin',
                            prefixIcon: Icon(Icons.wc),
                          ),
                          items: <String?>[null, 'Laki-laki', 'Wanita']
                              .map((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value ?? 'Please select'),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _kelaminController.text = newValue ?? '';
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pilih Jenis Kelamin';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 350, // Atur lebar sesuai kebutuhan
                        child: _buildTextFormField(
                          controller: _tanggal_lahirController,
                          labelText: 'Tanggal Lahir',
                          icon: Icons.calendar_today,
                          readOnly: true,
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _tanggal_lahirController.text =
                                    selectedDate.toString().split(' ')[0];
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your tanggal lahir';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 350, // Atur lebar sesuai kebutuhan
                        child: _buildTextFormField(
                          controller: _alamatController,
                          labelText: 'Alamat',
                          icon: Icons.home,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your alamat';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await _register();
                            } catch (e) {
                              print('An error occurred: $e');
                              _showQuickAlert(
                                context,
                                'Error',
                                'An error occurred',
                                QuickAlertType.error,
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
                          disabledBackgroundColor: Colors.white, // Text color
                          minimumSize: Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun ? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'Kembali ke Login',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    bool readOnly = false,
    Widget? suffixIcon,
    VoidCallback? onTap,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
