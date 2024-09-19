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
        ];
    }
}
