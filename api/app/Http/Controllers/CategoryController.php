<?php

namespace App\Http\Controllers;

use App\Helpers\BBPerTB;
use App\Helpers\BBPerU;
use App\Helpers\IMTPerU;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    function index()
    {
        return [
            'bmi' => IMTPerU::categoriesByIMT(),
            'sd_imt_per_u_0_sampai_60_bulan' => IMTPerU::categoriesBySD0Until60Month(),
            'sd_imt_per_u_5_sampai_18_tahun' => IMTPerU::categoriesBySD5Until18Year(),
            'sd_bb_per_u_0_sampai_60_bulan' => BBPerU::categoriesBySD0Until60Month(),
            'sd_tb_per_u_0_sampai_60_bulan' => BBPerU::categoriesBySD0Until60Month(),
            'sd_bb_per_tb_0_sampai_60_bulan' => BBPerTB::categoriesBySD0Until60Month(),
            'skor_badan' => [
                'min' => 0,
                'max' => 100,
                'data' => [
                    [
                        'min' => 0,
                        'status' => 'Tidak Sehat',
                        'color' => 'red',
                    ],
                    [
                        'min' => 40,
                        'status' => 'Cukup Sehat',
                        'color' => 'yellow',
                    ],
                    [
                        'min' => 60,
                        'status' => 'Sehat',
                        'color' => 'green',
                    ],
                    [
                        'min' => 80,
                        'status' => 'Sangat Sehat',
                        'color' => 'blue',
                    ],
                ]
            ],
            'lemak_tubuh_laki' => [
                'max' => 50,
                'data' => [
                    [
                        'min' => 6,
                        'status' => 'Sangat Sehat',
                        'color' => 'blue',
                    ],
                    [
                        'min' => 13,
                        'status' => 'Sehat',
                        'color' => 'green',
                    ],
                    [
                        'min' => 17,
                        'status' => 'Cukup Sehat',
                        'color' => 'yellow',
                    ],
                    [
                        'min' => 24,
                        'status' => 'Tidak Sehat',
                        'color' => 'red',
                    ],
                ]
            ],
            'lemak_tubuh_perempuan' => [
                'max' => 50,
                'data' => [
                    [
                        'min' => 14,
                        'status' => 'Sangat Sehat',
                        'color' => 'blue',
                    ],
                    [
                        'min' => 20,
                        'status' => 'Sehat',
                        'color' => 'green',
                    ],
                    [
                        'min' => 24,
                        'status' => 'Cukup Sehat',
                        'color' => 'yellow',
                    ],
                    [
                        'min' => 31,
                        'status' => 'Tidak Sehat',
                        'color' => 'red',
                    ],
                ]
            ],
        ];
    }
}
