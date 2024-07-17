<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\DailyTracking;

class DailyTrackingController extends Controller
{
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'vehicule_id' => 'required|integer',
            'chauffeur_id' => 'required|integer',
            'kilometrage' => 'required|integer',
            'carburant' => 'required|numeric',
            'preuve' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $dailyTracking = new DailyTracking();
        $dailyTracking->vehicule_id = $request->vehicule_id;
        $dailyTracking->chauffeur_id = $request->chauffeur_id;
        $dailyTracking->kilometrage = $request->kilometrage;
        $dailyTracking->carburant = $request->carburant;
        $dailyTracking->preuve = $request->preuve;

        $dailyTracking->save();

        return response()->json(['message' => 'Données sauvegardées avec succès'], 201);
    }
}
