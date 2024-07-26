<?php

namespace App\Http\Controllers;

use App\Models\DataRealtime;
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
            'perangkat_id' => 'required',
            'berat' => 'required|decimal:1,3',
            'tinggi' => 'required|decimal:1,3',
        ]);

        DataRealtime::updateOrCreate($req->only(['perangkat_id']), $req->only(['berat', 'tinggi']));

        return Response([
            'success' => true,
            'message' => 'data berhasil disimpan',
        ]);
    }
}
