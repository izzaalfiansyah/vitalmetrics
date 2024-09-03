<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PerangkatUser extends Model
{
    use HasFactory;

    protected $table = 'perangkat_user';

    protected $fillable = [
        'nomor_serial',
        'user_id',
        'nomor_serial_tinggi',
        'kalibrasi_tinggi',
        'kalibrasi_tinggi_on',
        'kalibrasi_berat',
        'kalibrasi_berat_on',
    ];

    protected function casts(): array
    {
        return [
            'kalibrasi_tinggi_on' => 'boolean',
            'kalibrasi_berat_on' => 'boolean',
        ];
    }
}
