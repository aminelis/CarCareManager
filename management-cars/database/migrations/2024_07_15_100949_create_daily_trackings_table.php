<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDailyTrackingsTable extends Migration
{
    public function up()
    {
        Schema::create('daily_trackings', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('vehicule_id');
            $table->unsignedBigInteger('chauffeur_id');
            $table->integer('kilometrage');
            $table->decimal('carburant', 8, 2);
            $table->string('preuve'); // URL de la photo ou vidéo
            $table->timestamps();

            // Clés étrangères
            $table->foreign('vehicule_id')->references('id')->on('vehicules');
            $table->foreign('chauffeur_id')->references('id')->on('chauffeurs');
        });
    }

    public function down()
    {
        Schema::dropIfExists('daily_trackings');
    }
}
