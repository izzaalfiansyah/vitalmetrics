<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DataPengukuran extends Model
{
    use HasFactory;

    protected $table = 'data_pengukuran';

    protected $fillable = [
        'user_id',
        'user_umur',
        'perangkat_id',
        'tinggi',
        'berat',
    ];

    protected $with = ['user', 'perangkat'];

    function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    function perangkat()
    {
        return $this->belongsTo(PerangkatUser::class);
    }

    protected $appends = [
        'bmi',
        'lemak_tubuh',
    ];

    protected function bmi(): Attribute
    {
        return new Attribute(
            get: function () {
                $bmi = $this->berat / ($this->tinggi / 100) ** 2;

                if ($this->user_umur < 18) {
                    $bmi = $bmi / 4;
                } else if ($this->user_umur < 5) {
                    $bmi = $bmi / 4;
                }

                return $bmi;
            }
        );
    }

    protected function lemakTubuh(): Attribute
    {
        return new Attribute(
            get: function () {
                $lemak_tubuh = (1.2 * $this->bmi) + (0.23 * $this->user_umur) - 5.4;

                if ($this->user->jenis_kelamin) {
                    $lemak_tubuh = $lemak_tubuh - 10.8;
                }

                return $lemak_tubuh;
            }
        );
    }
}
