import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class TorosScreen extends StatefulWidget {
  const TorosScreen({super.key});

  @override
  State<TorosScreen> createState() => _TorosScreenState();
}
  

class _TorosScreenState extends State<TorosScreen> {

  List<CatalogItem> _catalog = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de toros'),
        elevation: 0,
        backgroundColor: Color.fromRGBO(44, 5, 5, 0.956),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: _catalog.isEmpty
          ? Center(
              child: Text(
                'El catálogo de toros está vacío.',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            )
          : ListView.builder(
              itemCount: _catalog.length,
              itemBuilder: (context, index) {
                final item = _catalog[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                  shadowColor: Colors.indigo.shade100,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: ClipOval(
                      child: item.image != null
                          ? Image.file(item.image!,
                              width: 60, height: 60, fit: BoxFit.cover)
                          : Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.shade300,
                              child: Icon(Icons.image,
                                  color: Colors.grey.shade600, size: 40),
                            ),
                    ),
                    title: Text(
                      item.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      item.description,
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.indigo.shade400),
                          onPressed: () => _showEditItemDialog(item, index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red.shade400),
                          onPressed: () => _deleteItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        backgroundColor: Color.fromRGBO(44, 5, 5, 0.956),
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  void _showAddItemDialog() {
    CatalogItem newItem = CatalogItem();
    _showItemDialog(newItem, isEditing: false);
  }

  void _showEditItemDialog(CatalogItem item, int index) {
    CatalogItem editedItem = CatalogItem(
      name: item.name,
      description: item.description,
      image: item.image,
    );
    _showItemDialog(editedItem, isEditing: true, index: index);
  }

  void _showItemDialog(CatalogItem item,
      {required bool isEditing, int? index}) {
    TextEditingController nameController =
        TextEditingController(text: item.name);
    TextEditingController descriptionController =
        TextEditingController(text: item.description);
    ImagePicker picker = ImagePicker();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Editar artículo' : 'Añadir artículo'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      item.image = File(pickedFile.path);
                    });
                  }
                },
                child: item.image != null
                    ? ClipOval(
                        child: Image.file(item.image!,
                            width: 100, height: 100, fit: BoxFit.cover),
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.add_photo_alternate,
                            color: Colors.grey, size: 50),
                      ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text(isEditing ? 'Guardar' : 'Añadir'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(44, 5, 5, 0.956),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              setState(() {
                item.name = nameController.text;
                item.description = descriptionController.text;
                if (isEditing && index != null) {
                  _catalog[index] = item;
                } else {
                  _catalog.add(item);
                }
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _catalog.removeAt(index);
    });
  }
}

class CatalogItem {
  String name;
  String description;
  File? image;

  CatalogItem({this.name = '', this.description = '', this.image});
}