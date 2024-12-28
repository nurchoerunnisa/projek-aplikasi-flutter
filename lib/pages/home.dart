import 'package:flutter/material.dart';
import 'package:plantcare/pages/login.dart';
import 'package:plantcare/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:plantcare/pages/plant_detail.dart';
import 'package:plantcare/pages/add_plant.dart';

class HomePage extends StatelessWidget {
  final String username;
  final bool isAdmin;

  HomePage({required this.username, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grow My Plants 🌿',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Logika logout
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image dari URL
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1601773784796-ff2c3a8e430f', // URL Gambar Header
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Selamat Datang
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '👋 Selamat datang, $username!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Statistik Singkat
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatusCard(
                        Icons.grass, '12', 'Total Tanaman', Colors.green),
                    _buildStatusCard(
                        Icons.eco, '10', 'Tanaman Sehat', Colors.blue),
                    _buildStatusCard(
                        Icons.warning, '2', 'Butuh Perhatian', Colors.orange),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Daftar Tanaman
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '🌱 Daftar Tanaman Anda',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),

            // GridView untuk menampilkan tanaman
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantDetailPage(
                              plantName: index == 0
                                  ? 'Tanaman Peperomia Obtusifolia'
                                  : 'Tanaman Calathea White Star',
                              plantDescription: index == 0
                                  ? 'Peperomia Obtusifolia, yang sering disebut "Baby Rubber Plant", dikenal sebagai tanaman yang mudah dirawat serta tahan terhadap berbagai kondisi lingkungan. Peperomia Obtusifolia tidak hanya berfungsi sebagai dekorasi cantik di dalam ruangan, tetapi juga membantu meningkatkan kualitas udara dengan kemampuannya menyerap polutan'
                                  : 'Tanaman calathea white tidak hanya dikenal karena keindahannya, tetapi juga karena kemampuannya sebagai pembersih udara alami. Tanaman ini menyukai kelembapan tinggi serta cahaya tidak langsung. Daunnya yang bergerak mengikuti siklus siang dan malam',
                              plantImageUrl: index == 0
                                  ? 'https://th.bing.com/th/id/OIP.UPqbRyedAL1HMYVJKp32cAHaHa?rs=1&pid=ImgDetMain'
                                  : 'https://m.media-amazon.com/images/I/81XzBBFJH-L._AC_SL1500_.jpg',
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            // Gambar tanaman dari URL
                            Expanded(
                              child: Image.network(
                                index == 0
                                    ? 'https://th.bing.com/th/id/OIP.UPqbRyedAL1HMYVJKp32cAHaHa?rs=1&pid=ImgDetMain'
                                    : 'https://m.media-amazon.com/images/I/81XzBBFJH-L._AC_SL1500_.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    index == 0
                                        ? 'Peperomia Obtusifolia'
                                        : 'Tanaman Calathea White Star',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    index == 0
                                        ? 'Status: Sehat'
                                        : 'Status: Butuh Penyiraman',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 20, 20, 20)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16),

            // Tombol Aksi Cepat
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddPlantPage(), // Navigasi ke halaman tambah tanaman
                      ),
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.black),
                  label: Text('Tambah Tanaman Baru'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: EdgeInsets.symmetric(vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun Card status tanaman
  Widget _buildStatusCard(
      IconData icon, String count, String label, Color iconColor) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 40),
        SizedBox(height: 8),
        Text(count,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }
}
