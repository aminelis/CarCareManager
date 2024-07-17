<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FuelPurchase extends Model
{
    protected $fillable = ['amount', 'liters', 'invoice_photo', 'vehicule_id', 'chauffeur_id'];

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
}
