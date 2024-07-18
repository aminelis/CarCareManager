import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class AchatCarburantScreen extends StatefulWidget {
  const AchatCarburantScreen({Key? key}) : super(key: key);

  @override
  _AchatCarburantScreenState createState() => _AchatCarburantScreenState();
}

class _AchatCarburantScreenState extends State<AchatCarburantScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _litresController = TextEditingController();
  final TextEditingController _vehiculeIdController = TextEditingController();
  final TextEditingController _chauffeurIdController = TextEditingController();
  String _facturePhotoUrl = '';
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  @override
  void dispose() {
    _montantController.dispose();
    _litresController.dispose();
    _vehiculeIdController.dispose();
    _chauffeurIdController.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _facturePhotoUrl = pickedFile.path;
      });
    }
  }

  Future<void> _sauvegarderAchatCarburant() async {
    if (_formKey.currentState!.validate()) {
      final url = 'http://10.0.2.2/Fuel-Purchase'; // URL pour l'API d'achat de carburant

      Map<String, dynamic> requestBody = {
        'amount': double.parse(_montantController.text),
        'liters': double.parse(_litresController.text),
        'invoice_photo': _facturePhotoUrl,
        'vehicule_id': int.parse(_vehiculeIdController.text),
        'chauffeur_id': int.parse(_chauffeurIdController.text),
      };

      try {
        final response = await _dio.post(
          url,
          data: jsonEncode(requestBody),
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Données sauvegardées avec succès')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erreur lors de la sauvegarde des données')),
          );
        }
      } catch (e) {
        if (e is DioError) {
          final response = e.response;
          if (response != null) {
            print('Erreur lors de l\'envoi de la requête: ${e.message}, ${response.statusCode}');
          } else {
            print('Erreur lors de l\'envoi de la requête: ${e.message}');
          }
        } else {
          print('Erreur lors de l\'envoi de la requête: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la sauvegarde des données')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achat de Carburant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _montantController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Montant',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le montant';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _litresController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de litres',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nombre de litres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _vehiculeIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'ID du véhicule',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer l\'ID du véhicule';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _chauffeurIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'ID du chauffeur',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer l\'ID du chauffeur';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _captureImage,
                  child: const Text('Prendre Photo de la Facture'),
                ),
                const SizedBox(height: 20),
                if (_facturePhotoUrl.isNotEmpty)
                  Image.file(
                    File(_facturePhotoUrl),
                    height: 100,
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: _sauvegarderAchatCarburant,
          child: const Text('Sauvegarder'),
        ),
      ),
    );
  }
}
