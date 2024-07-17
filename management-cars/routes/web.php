<?php
use Illuminate\Support\Facades\Route;


/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});
$router->post('/releves-quotidiens', 'DailyTrackingController@store');
$router->post('/vehicules', 'VehicleController@store');
$router->post('/Fuel-Purchase', 'FuelPurchaseController@store');
$router->post('/Vehicle-Cleaning', 'VehicleCleaningController@store');





