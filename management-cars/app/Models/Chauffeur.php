<?php
// app/Models/Chauffeur.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Chauffeur extends Model
{
    protected $fillable = [
        'nom', 'prenom',
    ];

    public function dailyTrackings()
    {
        return $this->hasMany(DailyTracking::class, 'chauffeur_id');
    }

    public function fuelPurchases()
    {
        return $this->hasMany(FuelPurchase::class, 'chauffeur_id');
    }

    public function VehiclesCleaning()
    {
        return $this->hasMany(VehicleCleaning::class, 'chauffeur_id');
    }
}
