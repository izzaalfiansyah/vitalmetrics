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

    protected function casts(): array
    {
        return [
            'tinggi' => 'float',
            'berat' => 'float',
        ];
    }

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
        'air_dalam_tubuh',
        'massa_otot_tubuh',
        'massa_tulang',
        'massa_tulang_persentase',
        'massa_protein',
        'massa_protein_persentase',
        'berat_badan_ideal',
        'skor_badan',
        'status_gizi',
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

                if ($this->user->jenis_kelamin == 'l') {
                    $lemak_tubuh = $lemak_tubuh - 10.8;
                }

                return $lemak_tubuh;
            }
        );
    }

    protected function airDalamTubuh(): Attribute
    {
        return new Attribute(
            get: function () {
                if ($this->user->jenis_kelamin == 'l') {
                    $air_dalam_tubuh = ((2.447 - 0.09156 * $this->user_umur + 0.1074 * $this->tinggi + 0.3362 * $this->berat) / $this->berat) * 100;
                } else {
                    $air_dalam_tubuh = ((2.097 - 0.1069 * $this->user_umur + 0.2466 * $this->tinggi + 0.1069 * $this->berat) / $this->berat) * 100;
                }

                return $air_dalam_tubuh;
            }
        );
    }

    protected function massaOtotTubuh(): Attribute
    {
        return new Attribute(
            get: function () {
                $nilaiEtnis = "asia" == "asia" ? 0.4 : 0;
                $nilaiJenisKelamin = $this->user->jenis_kelamin == 'l' ? 1 : 0;
                $massa_otot_tubuh = 0.244 * $this->berat + 7.8 * ($this->tinggi / 100) - 0.098 * $this->user_umur + 6.6 * $nilaiJenisKelamin + $nilaiEtnis;

                return $massa_otot_tubuh;
            }
        );
    }

    protected function massaTulang(): Attribute
    {
        return new Attribute(
            get: function () {
                $massa_tulang = 0.24571 * ($this->berat ** 0.731) *  ($this->tinggi ** 0.42);

                return $massa_tulang;
            }
        );
    }

    protected function massaTulangPersentase(): Attribute
    {
        return new Attribute(
            get: function () {
                $massa_tulang_persentase = $this->massa_tulang / $this->berat * 100;

                return $massa_tulang_persentase;
            }
        );
    }

    protected function massaProtein(): Attribute
    {
        return new Attribute(
            get: function () {
                $lbm = $this->berat * (1 - $this->lemak_tubuh / 100);
                $massa_protein = 0.19 * $lbm;

                return $massa_protein;
            }
        );
    }

    protected function massaProteinPersentase(): Attribute
    {
        return new Attribute(
            get: function () {
                $massa_protein_persentase = $this->massa_protein / $this->berat * 100;

                return $massa_protein_persentase;
            }
        );
    }

    protected function beratBadanIdeal(): Attribute
    {
        return new Attribute(
            get: function () {
                $nilaiJenisKelamin = $this->user->jenis_kelamin == 'l' ? 10 : 20;
                $berat_badan_ideal = $this->tinggi - 100 - (($this->tinggi - 100) / $nilaiJenisKelamin);

                return $berat_badan_ideal;
            }
        );
    }

    protected function skorBadan(): Attribute
    {
        return new Attribute(
            get: function () {
                $bmi = $this->bmi;
                $bfp = $this->lemak_tubuh;
                $skorBmi = 0;
                $skorBfp = 0;

                if ($bmi >= 18.5 && $bmi <= 24.9) {
                    $skorBmi = 100;
                } elseif ($bmi >= 25.0 && $bmi <= 29.9) {
                    $skorBmi = 100 - (($bmi - 24.9) / (29.9 - 24.9) * 25);
                } elseif ($bmi >= 30.0 && $bmi <= 34.9) {
                    $skorBmi = 75 - (($bmi - 29.9) / (34.9 - 29.9) * 25);
                } elseif ($bmi >= 35.0 && $bmi <= 39.9) {
                    $skorBmi = 50 - (($bmi - 34.9) / (39.9 - 34.9) * 25);
                } elseif ($bmi >= 40.0) {
                    $skorBmi = 25 - (($bmi - 39.9) / 5 * 24);
                } elseif ($bmi < 18.5) {
                    $skorBmi = 75 - ((18.5 - $bmi) / 18.5 * 74);
                } else {
                    $skorBmi = 0; // Default case, should not reach here.
                }

                if ($this->user->jenis_kelamin == 'l') {
                    if ($bfp < 10) {
                        $skorBfp = 100;
                    } elseif ($bfp < 15) {
                        $skorBfp = 100 - (($bfp - 10) / 5 * 20);
                    } elseif ($bfp < 20) {
                        $skorBfp = 80 - (($bfp - 15) / 5 * 20);
                    } elseif ($bfp < 25) {
                        $skorBfp = 60 - (($bfp - 20) / 5 * 20);
                    } elseif ($bfp < 30) {
                        $skorBfp = 40 - (($bfp - 25) / 5 * 20);
                    } else {
                        $skorBfp = 20 - (($bfp - 30) / 10 * 19);
                    }
                } else {
                    if ($bfp < 20) {
                        $skorBfp = 100;
                    } elseif ($bfp < 25) {
                        $skorBfp = 100 - (($bfp - 20) / 5 * 20);
                    } elseif ($bfp < 30) {
                        $skorBfp = 80 - (($bfp - 25) / 5 * 20);
                    } elseif ($bfp < 35) {
                        $skorBfp = 60 - (($bfp - 30) / 5 * 20);
                    } elseif ($bfp < 40) {
                        $skorBfp = 40 - (($bfp - 35) / 5 * 20);
                    } else {
                        $skorBfp = 20 - (($bfp - 40) / 10 * 19);
                    }
                }

                return ($skorBmi + $skorBfp) / 2;
            }
        );
    }

    protected function statusGizi(): Attribute
    {
        return new Attribute(
            get: function () {
                if ($this->bmi < 18.5) {
                    return "kurus";
                } elseif ($this->bmi >= 18.5 && $this->bmi <= 24.9) {
                    return "normal";
                } else {
                    return "lebih";
                }
            }
        );
    }
}
