<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Vehicule extends Model
{
    protected $table = 'vehicules';

    protected $fillable = [
        'name',
        'model',
        'color',
        'year',
        // Ajoutez ici d'autres champs que vous avez ajoutés dans la migration
    ];

    // Relation avec DailyTracking
    public function dailyTrackings()
    {
        return $this->hasMany(DailyTracking::class, 'vehicule_id');
    }

    public function fuelPurchases()
    {
        return $this->hasMany(FuelPurchase::class, 'vehicule_id');
    }

    public function VehiclesCleaning()
    {
        return $this->hasMany(VehicleCleaning::class, 'vehicule_id');
    }
    

    // Définissez vos autres relations ici si nécessaire
}
