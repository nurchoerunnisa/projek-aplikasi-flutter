import 'package:flutter/material.dart';
import 'package:plantcare/models/plant.dart' as model;
import 'package:provider/provider.dart';
import 'package:plantcare/provider/plant_provider.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  Future<void> _addPlant() async {
    final plantProvider = Provider.of<PlantProvider>(context, listen: false);

    final name = _nameController.text;
    final description = _descriptionController.text;
    final imageUrl = _imageUrlController.text;

    final newPlant = model.Plant(
      id: DateTime.now().toString(),
      name: name,
      description: description,
      imageUrl: imageUrl,
    );

    await plantProvider.addPlant(newPlant);

    Navigator.pop(
        context); // Kembali ke halaman sebelumnya setelah menambah tanaman
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tanaman'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Tanaman'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL Gambar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPlant,
              child: Text('Tambah Tanaman'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
