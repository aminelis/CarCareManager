<?php

namespace App\Http\Controllers;

use App\Models\FuelPurchase;
use Illuminate\Http\Request;

class FuelPurchaseController extends Controller
{
    public function index()
    {
        return response()->json(FuelPurchase::with(['vehicule', 'chauffeur'])->get());
    }

    public function show($id)
    {
        return response()->json(FuelPurchase::with(['vehicule', 'chauffeur'])->find($id));
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'amount' => 'required|numeric',
            'liters' => 'required|numeric',
            'invoice_photo' => 'required|string',
            'vehicule_id' => 'required|exists:vehicules,id',
            'chauffeur_id' => 'required|exists:chauffeurs,id',
        ]);

        $fuelPurchase = FuelPurchase::create($request->all());
        return response()->json($fuelPurchase->load(['vehicule', 'chauffeur']), 201);
    }

    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'amount' => 'numeric',
            'liters' => 'numeric',
            'invoice_photo' => 'string',
            'vehicule_id' => 'exists:vehicules,id',
            'chauffeur_id' => 'exists:chauffeurs,id',
        ]);

        $fuelPurchase = FuelPurchase::findOrFail($id);
        $fuelPurchase->update($request->all());

        return response()->json($fuelPurchase->load(['vehicule', 'chauffeur']), 200);
    }

    public function destroy($id)
    {
        FuelPurchase::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
