import 'package:flutter/material.dart';
import 'plant_form.dart';

class ManagePlants extends StatefulWidget {
  @override
  _ManagePlantsState createState() => _ManagePlantsState();
}

class _ManagePlantsState extends State<ManagePlants> {
  List<Map<String, dynamic>> plants = [
    {'id': 1, 'name': 'Rose', 'type': 'Flower'},
    {'id': 2, 'name': 'Cactus', 'type': 'Succulent'},
  ];

  void _addPlant(Map<String, dynamic> newPlant) {
    setState(() {
      plants.add(newPlant);
    });
  }

  void _editPlant(int index, Map<String, dynamic> updatedPlant) {
    setState(() {
      plants[index] = updatedPlant;
    });
  }

  void _deletePlant(int index) {
    setState(() {
      plants.removeAt(index);
    });
  }

  void _openForm({Map<String, dynamic>? plant, int? index}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantForm(
          plant: plant,
          onSave: (Map<String, dynamic> plantData) {
            if (plant == null) {
              _addPlant(plantData);
            } else {
              _editPlant(index!, plantData);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Plants'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return ListTile(
            title: Text(plant['name']),
            subtitle: Text(plant['type']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _openForm(plant: plant, index: index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deletePlant(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
