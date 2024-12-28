import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:plantcare/pages/welcome.dart';
import 'package:plantcare/provider/auth_provider.dart';
import 'package:plantcare/provider/plant_provider.dart';

import 'pages/admin/admin_dashboard.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PlantProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSessionLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUserSession();
    setState(() {
      _isSessionLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSessionLoaded) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.role == 'admin') {
          return MaterialApp(
            title: 'Plant Care Admin',
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: const AdminDashboard(),
          );
        } else if (authProvider.role == 'user') {
          return MaterialApp(
            title: 'Plant Care User',
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: const WelcomePage(),
          );
        } else {
          return MaterialApp(
            title: 'Plant Care',
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: const WelcomePage(),
          );
        }
      },
    );
  }
}
