import 'package:flutter/material.dart';

class PlantForm extends StatefulWidget {
  final Map<String, dynamic>? plant;
  final Function(Map<String, dynamic>) onSave;

  PlantForm({this.plant, required this.onSave});

  @override
  _PlantFormState createState() => _PlantFormState();
}

class _PlantFormState extends State<PlantForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _typeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.plant?['name'] ?? '');
    _typeController = TextEditingController(text: widget.plant?['type'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSave({
        'id': widget.plant?['id'] ?? DateTime.now().millisecondsSinceEpoch,
        'name': _nameController.text,
        'type': _typeController.text,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant == null ? 'Add Plant' : 'Edit Plant'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Plant Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter plant name' : null,
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Plant Type'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter plant type' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
