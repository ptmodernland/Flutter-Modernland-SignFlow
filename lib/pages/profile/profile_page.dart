import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    var user = SessionManager.getUser();

    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<UserDTO?>(
            future: SessionManager.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the future is loading, show a loading indicator or placeholder
                return CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data != null) {
                UserDTO user = snapshot.data!;
                return Column(
                  children: [
                    Text('ID: ${user.idUser}'),
                    Text('Username: ${user.username}'),
                    Text('Name: ${user.nama}'),
                    Text('Level: ${user.level}'),
                    Text('Email: ${user.email}'),
                    Text('Gender: ${user.jk}'),
                    Text('Status: ${user.status}'),
                  ],
                );
              } else {
                return Text('User not found');
              }
            },
          ),
        ],
      ),
    );
  }
}
