<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VehicleCleaning extends Model
{
    use HasFactory;

    protected $fillable = [
        'vehicule_id',
        'chauffeur_id',
        'before_photos',
        'after_photos',
        'before_videos',
        'after_videos',
    ];

    public function vehicule()
    {
        return $this->belongsTo(Vehicule::class, 'vehicule_id');
    }

    public function chauffeur()
    {
        return $this->belongsTo(Chauffeur::class, 'chauffeur_id');
    }
}
