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
        Schema::table('perangkat_user', function (Blueprint $table) {
            $table->float('kalibrasi_tinggi')->default(0);
            $table->boolean('kalibrasi_tinggi_on')->default(false);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('perangkat_user', function (Blueprint $table) {
            $table->dropColumn('kalibrasi_tinggi');
            $table->dropColumn('kalibrasi_tinggi_on');
        });
    }
};
