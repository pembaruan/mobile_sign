import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class HomePage extends StatelessWidget {
  final Map userData;

  HomePage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'WELCOME',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue:
                            userData['username'] ?? 'Username not available',
                        decoration: InputDecoration(labelText: 'Username'),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue:
                            userData['email'] ?? 'Email not available',
                        decoration: InputDecoration(labelText: 'Email'),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue: userData['kelamin'] ?? 'Not specified',
                        decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue:
                            userData['tanggal_lahir'] ?? 'Not specified',
                        decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue:
                            userData['alamat'] ?? 'Address not available',
                        decoration: InputDecoration(labelText: 'Alamat'),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showLogoutAlert(context);
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(420, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutAlert(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Logout',
      text: 'Are you sure you want to logout?',
      confirmBtnText: 'Oke',
      cancelBtnText: 'Cancel',
      onConfirmBtnTap: () {
        Navigator.pop(context); // Close the alert
        Navigator.pop(context); // Logout and go back to the login screen
      },
      onCancelBtnTap: () {
        Navigator.pop(context); // Close the alert without logging out
      },
    );
  }
}
