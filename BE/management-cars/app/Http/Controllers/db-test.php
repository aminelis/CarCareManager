<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;
use OpenApi\Annotations as OA;

class UtilityController extends BaseController
{
    /**
     * @OA\Get(
     *     path="/db-test",
     *     summary="Test database connection",
     *     @OA\Response(
     *         response=200,
     *         description="Database connection is OK"
     *     ),
     *     @OA\Response(
     *         response=500,
     *         description="Could not connect to the database"
     *     )
     * )
     */
    public function dbTest()
    {
        try {
            \DB::connection()->getPdo();
            return response()->json("Database connection is OK.", 200);
        } catch (\Exception $e) {
            return response()->json("Could not connect to the database. Error: " . $e->getMessage(), 500);
        }
    }
}
