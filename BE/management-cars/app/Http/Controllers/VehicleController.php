<?php

namespace App\Http\Controllers;

use App\Models\Vehicule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class VehicleController extends Controller
{
    public function store(Request $request)
    {
        
    
        
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
            'model' => 'required|string',
            'color' => 'nullable|string',
            'year' => 'required|integer',
            // Ajoutez ici d'autres règles de validation si nécessaire
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $vehicule = Vehicule::create([
            'name' => $request->name,
            'model' => $request->model,
            'color' => $request->color,
            'year' => $request->year,
            // Ajoutez ici d'autres champs à insérer
        ]);

        return response()->json(['message' => 'Ressource créée avec succès', 'data' => $vehicule], 201);
    }

    // Implémentez d'autres méthodes du contrôleur pour les actions CRUD nécessaires
}
