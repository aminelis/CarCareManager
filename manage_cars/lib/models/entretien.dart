// entretien.dart

class EntretienQuotidien {
  int id;
  int vehiculeId;
  DateTime date;
  double kilometrage;
  String carburantPhotoUrl;

  EntretienQuotidien({
    required this.id,
    required this.vehiculeId,
    required this.date,
    required this.kilometrage,
    required this.carburantPhotoUrl,
  });
}

class Nettoyage {
  int id;
  int vehiculeId;
  DateTime date;
  String avantPhotoUrl;
  String apresPhotoUrl;

  Nettoyage({
    required this.id,
    required this.vehiculeId,
    required this.date,
    required this.avantPhotoUrl,
    required this.apresPhotoUrl,
  });
}

class AchatCarburant {
  int id;
  int vehiculeId;
  DateTime date;
  double montant;
  double litres;
  String facturePhotoUrl;

  AchatCarburant({
    required this.id,
    required this.vehiculeId,
    required this.date,
    required this.montant,
    required this.litres,
    required this.facturePhotoUrl,
  });
}

// entretien.dart

class SuiviQuotidien {
  int id;
  int vehiculeId;
  DateTime date;
  double kilometrage;
  String carburantPhotoUrl;  // URL de la preuve (photo ou vidéo)

  SuiviQuotidien({
    required this.id,
    required this.vehiculeId,
    required this.date,
    required this.kilometrage,
    required this.carburantPhotoUrl,
  });
}

