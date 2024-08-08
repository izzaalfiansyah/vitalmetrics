<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MenuMakanan extends Model
{
    use HasFactory;

    protected $table = 'menu_makanan';

    protected $fillable = [
        'waktu',
        'umur_min',
        'umur_max',
        'nama',
        'kategori_gizi',
        'bahan',
    ];

    protected function casts(): array
    {
        return [
            'bahan' => 'object',
            'bahan.*.berat' => 'float',
            'bahan.*.energi' => 'float',
            'bahan.*.protein' => 'float',
            'bahan.*.lemak' => 'float',
            'bahan.*.kh' => 'float',
        ];
    }

    protected $appends = [
        'waktu_detail',
    ];

    protected function waktuDetail(): Attribute
    {
        return new Attribute(
            get: function () {
                $detail = ['', 'Makan Pagi', 'Selingan Pagi', 'Makan Siang', 'Selingan Sore', 'Makan Malam'];

                return $detail[(int) $this->waktu];
            }
        );
    }

    public $timestamps = false;
}
