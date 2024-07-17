<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFuelPurchasesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('fuel_purchases', function (Blueprint $table) {
            $table->id();
            $table->decimal('amount', 8, 2);
            $table->decimal('liters', 8, 2);
            $table->string('invoice_photo');
            $table->unsignedBigInteger('vehicule_id');
            $table->unsignedBigInteger('chauffeur_id');
            $table->timestamps();

            $table->foreign('vehicule_id')->references('id')->on('vehicules')->onDelete('cascade');
            $table->foreign('chauffeur_id')->references('id')->on('chauffeurs')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('fuel_purchases');
    }
}
