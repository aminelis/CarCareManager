<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVehicleCleaningsTable extends Migration
{
    public function up()
    {
        Schema::create('vehicle_cleanings', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('vehicule_id');
            $table->unsignedBigInteger('chauffeur_id');
            $table->string('before_photos'); // Chemin vers les photos avant nettoyage
            $table->string('after_photos'); // Chemin vers les photos après nettoyage
            $table->string('before_videos')->nullable(); // Chemin vers les vidéos avant nettoyage
            $table->string('after_videos')->nullable(); // Chemin vers les vidéos après nettoyage
            $table->timestamps();

            // Clés étrangères
            $table->foreign('vehicule_id')->references('id')->on('vehicules')->onDelete('cascade');
            $table->foreign('chauffeur_id')->references('id')->on('chauffeurs')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('vehicle_cleanings');
    }
}
