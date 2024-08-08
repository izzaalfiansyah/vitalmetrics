<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('menu_makanan', function (Blueprint $table) {
            $table->id();
            $table->enum('waktu', ['1', '2', '3', '4', '5'])->comment('1: makan pagi, 2: selingan pagi, 3: makan siang, 4: selingan sore, 5: makan malam');
            $table->integer('umur_min');
            $table->integer('umur_max');
            $table->enum('kategori_gizi', ['normal', 'kurang', 'lebih']);
            $table->string('nama');
            $table->json('bahan');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('menu_makanan');
    }
};
