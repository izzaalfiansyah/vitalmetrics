<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DataRealtime extends Model
{
    use HasFactory;

    protected $table = 'data_realtime';

    protected $fillable = [
        'perangkat_id',
        'tinggi',
        'berat',
        'created_at',
    ];

    protected function casts(): array
    {
        return [
            'tinggi' => 'float',
            'berat' => 'float',
        ];
    }

    public $timestamps = false;
}
