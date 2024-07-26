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
    ];

    public $timestamps = false;
}
