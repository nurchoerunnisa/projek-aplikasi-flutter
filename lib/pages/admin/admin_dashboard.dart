import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.green,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(16.0),
        children: [
          _buildAdminCard(
            context,
            title: 'Manage Plants',
            icon: Icons.eco,
            route: '/manage-plants',
          ),
          _buildAdminCard(
            context,
            title: 'Manage Users',
            icon: Icons.person,
            route: '/manage-users',
          ),
          _buildAdminCard(
            context,
            title: 'Settings',
            icon: Icons.settings,
            route: '/settings',
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCard(BuildContext context,
      {required String title, required IconData icon, required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.green),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
