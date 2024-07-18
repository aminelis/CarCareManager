<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\DB;

class EnsureDatabaseConnection
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        try {
            DB::connection()->getPdo();
        } catch (\Exception $e) {
            return response()->json(['error' => 'Could not connect to the database. Please check your configuration.'], 500);
        }

        return $next($request);
    }
}
