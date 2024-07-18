<?php

// App\Models\DailyTracking.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class DailyTracking extends Model
{
    protected $connection = 'mysql'; // Assurez-vous que 'mysql' correspond à votre connexion configurée
    protected $table = 'daily_trackings';

    protected $fillable = [
        'vehicule_id', 'chauffeur_id', 'kilometrage', 'carburant', 'preuve',
    ];

    // Relation avec Vehicule
    public function vehicule()
    {
        return $this->belongsTo(Vehicule::class, 'vehicule_id');
    }

    // Relation avec Chauffeur
    public function chauffeur()
    {
        return $this->belongsTo(Chauffeur::class, 'chauffeur_id');
    }

    // Assurez-vous que la connexion est correctement définie si nécessaire
}
