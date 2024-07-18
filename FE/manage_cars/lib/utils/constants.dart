import 'package:flutter/material.dart';
import 'package:manage_cars/models/vehicle.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(vehicle.name),
        subtitle: Text(vehicle.licensePlate),
        leading: vehicle.imageUrl != null ? Image.network(vehicle.imageUrl) : const Icon(Icons.directions_car),
        onTap: () {
          Navigator.pushNamed(context, '/vehicle-detail', arguments: vehicle);
        },
      ),
    );
  }
}
