import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class VehicleCleaningScreen extends StatefulWidget {
  const VehicleCleaningScreen({Key? key}) : super(key: key);

  @override
  _VehicleCleaningScreenState createState() => _VehicleCleaningScreenState();
}

class _VehicleCleaningScreenState extends State<VehicleCleaningScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _vehiculeIdController = TextEditingController();
  final TextEditingController _chauffeurIdController = TextEditingController();
  List<String> _beforePhotos = [];
  List<String> _afterPhotos = [];
  List<String> _beforeVideos = [];
  List<String> _afterVideos = [];
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  @override
  void dispose() {
    _vehiculeIdController.dispose();
    _chauffeurIdController.dispose();
    super.dispose();
  }

  Future<void> _captureImage(bool isBefore) async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (isBefore) {
          _beforePhotos.add(pickedFile.path);
        } else {
          _afterPhotos.add(pickedFile.path);
        }
      });
    }
  }

  Future<void> _captureVideo(bool isBefore) async {
    final XFile? pickedFile =
    await _picker.pickVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (isBefore) {
          _beforeVideos.add(pickedFile.path);
        } else {
          _afterVideos.add(pickedFile.path);
        }
      });
    }
  }

  Future<void> _sauvegarderNettoyage() async {
    if (_formKey.currentState!.validate()) {
      final url = 'http://10.0.2.2/Vehicle-Cleaning'; // Mettez à jour l'URL ici

      Map<String, dynamic> requestBody = {
        'vehicule_id': int.parse(_vehiculeIdController.text),
        'chauffeur_id': int.parse(_chauffeurIdController.text),
        'before_photos': _beforePhotos,
        'after_photos': _afterPhotos,
        'before_videos': _beforeVideos,
        'after_videos': _afterVideos,
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
        title: const Text('Nettoyage de Véhicule'),
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
                  onPressed: () => _captureImage(true),
                  child: const Text('Prendre Photo Avant'),
                ),
                const SizedBox(height: 20),
                if (_beforePhotos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Photos Avant:'),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _beforePhotos.map((photo) => Image.file(File(photo), height: 100)).toList(),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _captureVideo(true),
                  child: const Text('Enregistrer Vidéo Avant'),
                ),
                const SizedBox(height: 20),
                if (_beforeVideos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Vidéos Avant:'),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _beforeVideos.map((video) => Text(video)).toList(),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _captureImage(false),
                  child: const Text('Prendre Photo Après'),
                ),
                const SizedBox(height: 20),
                if (_afterPhotos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Photos Après:'),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _afterPhotos.map((photo) => Image.file(File(photo), height: 100)).toList(),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _captureVideo(false),
                  child: const Text('Enregistrer Vidéo Après'),
                ),
                const SizedBox(height: 20),
                if (_afterVideos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Vidéos Après:'),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _afterVideos.map((video) => Text(video)).toList(),
                      ),
                    ],
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
          onPressed: _sauvegarderNettoyage,
          child: const Text('Sauvegarder'),
        ),
      ),
    );
  }
}
