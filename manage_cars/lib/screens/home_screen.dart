import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_cars/screens/suiviquotidien_screen.dart';  // Importez les écrans nécessaires
import 'package:manage_cars/screens/nettoyage_screen.dart';
import 'package:manage_cars/screens/achatcarburant_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildStyledButton(
                context,
                icon: Icons.calendar_today,
                text: 'Suivi Quotidien',
                screen: const SuiviQuotidienScreen(),
              ),
              const SizedBox(height: 20),
              _buildStyledButton(
                context,
                icon: Icons.cleaning_services,
                text: 'Nettoyage du Véhicule',
                screen: const VehicleCleaningScreen(),
              ),
              const SizedBox(height: 20),
              _buildStyledButton(
                context,
                icon: Icons.local_gas_station,
                text: 'Achat de Carburant',
                screen: const AchatCarburantScreen(),
              ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              SystemNavigator.pop();  // Quittez l'application
            },
            icon: const Icon(Icons.exit_to_app, size: 24),
            label: const Text(
              'Quitter',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.black45,
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledButton(BuildContext context, {required IconData icon, required String text, required Widget screen}) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      icon: Icon(icon, size: 24),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black45,
      ),
    );
  }
}
