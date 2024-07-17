import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class SuiviQuotidienScreen extends StatefulWidget {
  const SuiviQuotidienScreen({Key? key}) : super(key: key);

  @override
  _SuiviQuotidienScreenState createState() => _SuiviQuotidienScreenState();
}

class _SuiviQuotidienScreenState extends State<SuiviQuotidienScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idVehiculeController = TextEditingController();
  final TextEditingController _idChauffeurController = TextEditingController();
  final TextEditingController _kilometrageController = TextEditingController();
  final TextEditingController _carburantController = TextEditingController();
  String _carburantPhotoUrl = '';
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  @override
  void dispose() {
    _idVehiculeController.dispose();
    _idChauffeurController.dispose();
    _kilometrageController.dispose();
    _carburantController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      final url = 'http://10.0.2.2/releves-quotidiens';

      Map<String, dynamic> requestBody = {
        'vehicule_id': int.parse(_idVehiculeController.text),
        'chauffeur_id': int.parse(_idChauffeurController.text),
        'kilometrage': int.parse(_kilometrageController.text),
        'carburant': double.parse(_carburantController.text),
        'preuve': _carburantPhotoUrl, // Utilisez le chemin du fichier sélectionné
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
        title: const Text('Suivi Quotidien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextField(
                  controller: _idVehiculeController,
                  labelText: 'ID du véhicule',
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _idChauffeurController,
                  labelText: 'ID du chauffeur',
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _kilometrageController,
                  labelText: 'Kilométrage',
                ),
                const SizedBox(height: 20),
                _buildPhotoOrVideoPreview(),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _carburantController,
                  labelText: 'Carburant',
                ),
                const SizedBox(height: 20),
                _buildPhotoOrVideoPreviewKm(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,

            padding: const EdgeInsets.symmetric(vertical: 16.0),
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: _submitData,
          child: const Text('Sauvegarder'),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String labelText}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildPhotoOrVideoPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Preuve de carburant (photo ou vidéo)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        IconButton(
          icon: const Icon(Icons.camera_alt, color: Colors.blueAccent, size: 30),
          onPressed: () async {
            final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

            if (pickedFile != null) {
              setState(() {
                _carburantPhotoUrl = pickedFile.path;
              });
            }
          },
        ),
        const SizedBox(height: 8),
        if (_carburantPhotoUrl.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.file(
              File(_carburantPhotoUrl),
              height: 100,
            ),
          ),
      ],
    );
  }

  Widget _buildPhotoOrVideoPreviewKm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Preuve de kilométrage (photo ou vidéo)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        IconButton(
          icon: const Icon(Icons.camera_alt, color: Colors.blueAccent, size: 30),
          onPressed: () async {
            final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

            if (pickedFile != null) {
              setState(() {
                _carburantPhotoUrl = pickedFile.path;
              });
            }
          },
        ),
        const SizedBox(height: 8),
        if (_carburantPhotoUrl.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.file(
              File(_carburantPhotoUrl),
              height: 100,
            ),
          ),
      ],
    );
  }
}
