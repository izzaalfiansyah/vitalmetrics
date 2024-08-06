<?php

namespace App\Http\Controllers;

use App\Models\DataRealtime;
use App\Models\PerangkatUser;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class DataRealtimeController extends Controller
{
    function getByPerangkatId($perangkatId): Response
    {
        $data = DataRealtime::where('perangkat_id', $perangkatId)->first();

        if (!$data) {
            return Response([
                'success' => false,
                'message' => 'data tidak ditemukan',
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data berhasil diambil',
            'data' => $data,
        ]);
    }

    function create(Request $req): Response
    {
        $data = $req->validate([
            'nomor_serial' => 'required',
            'berat' => 'required|number',
            'tinggi' => 'required|number',
        ]);
        date_default_timezone_set('Asia/Jakarta');
        $data['created_at'] = date('Y-m-d H:i:s');

        $perangkat = PerangkatUser::where('nomor_serial', $req->nomor_serial)->first();

        if (!$perangkat) {
            return Response([
                'success' => false,
                'message' => "perangkat belum terdaftar",
            ], 400);
        }

        $dataRealtime = DataRealtime::where('perangkat_id', $perangkat->id)->first();

        if (!!$dataRealtime) {
            $dataRealtime->update($data);
        } else {
            DataRealtime::create($data);
        }

        return Response([
            'success' => true,
            'message' => 'data berhasil disimpan',
        ]);
    }
}
