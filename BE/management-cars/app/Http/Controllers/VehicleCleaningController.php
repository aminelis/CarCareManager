<?php

namespace App\Http\Controllers;

use App\Models\VehicleCleaning;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class VehicleCleaningController extends Controller
{
    public function store(Request $request)
    {
        // Valider les données du formulaire
        $validator = Validator::make($request->all(), [
            'vehicule_id' => 'required|exists:vehicules,id',
            'chauffeur_id' => 'required|exists:chauffeurs,id',
            'before_photos' => 'required|array',
            'after_photos' => 'required|array',
            'before_videos' => 'nullable|array',
            'after_videos' => 'nullable|array',
        ]);

        // Vérifier si la validation a échoué
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        // Traiter les photos et vidéos
        // Enregistrer les chemins dans la base de données
        $cleaning = VehicleCleaning::create([
            'vehicule_id' => $request->vehicule_id,
            'chauffeur_id' => $request->chauffeur_id,
            'before_photos' => json_encode($request->before_photos),
            'after_photos' => json_encode($request->after_photos),
            'before_videos' => $request->before_videos ? json_encode($request->before_videos) : null,
            'after_videos' => $request->after_videos ? json_encode($request->after_videos) : null,
        ]);

        return response()->json($cleaning, 201);
    }

    // Ajoutez d'autres méthodes selon vos besoins (par exemple, pour récupérer les nettoyages, etc.)
}
