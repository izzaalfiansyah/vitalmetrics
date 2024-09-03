<?php

namespace App\Http\Controllers;

use App\Models\DataRealtime;
use App\Models\PerangkatUser;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class PerangkatUserController extends Controller
{
    function index(): Response
    {
        $perangkat = PerangkatUser::paginate(10);

        return Response([
            'success' =>  true,
            'data' => $perangkat,
            'message' => 'data perangkat user berhasil diambil',
        ]);
    }

    function show($id): Response
    {
        $perangkat = PerangkatUser::find($id);

        if (!$perangkat) {
            return Response([
                'success' => false,
                'message' => 'data perangkat tidak ditemukan'
            ], 400);
        }

        return Response([
            'success' => true,
            'data' => $perangkat,
        ]);
    }

    function store(Request $req): Response
    {
        $data = $this->validate($req);

        if (!PerangkatUser::create($data)) {
            return Response([
                'success' => false,
                'message' => 'data perangkat gagal disimpan'
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data perangkat user berhasil disimpan',
        ]);
    }

    function update(Request $req, $id): Response
    {
        $perangkat = PerangkatUser::find($id);

        if (!$perangkat) {
            return Response([
                'success' => false,
                'message' => 'data perangkat tidak ditemukan',
            ], 400);
        }

        $data = $this->validate($req);

        if (!$perangkat->update($data)) {
            return Response([
                'success' => false,
                'message' => 'data perangkat user gagal disimpan',
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data perangkat user berhasil disimpan',
        ]);
    }

    function kalibrasiTinggiOn($id): Response
    {
        $perangkat = PerangkatUser::find($id);

        $perangkat->update(['kalibrasi_tinggi_on' => true]);

        return Response([
            'success' => true,
            'message' => 'kalibrasi untuk tinggi dihidupkan',
        ]);
    }

    function kalibrasiTinggiOff($id): Response
    {
        $perangkat = PerangkatUser::find($id);

        $perangkat->update(['kalibrasi_tinggi_on' => false]);

        return Response([
            'success' => true,
            'message' => 'kalibrasi untuk tinggi dimatikan',
        ]);
    }

    function kalibrasiBeratOn($id): Response
    {
        $perangkat = PerangkatUser::find($id);

        $perangkat->update(['kalibrasi_berat_on' => true]);

        return Response([
            'success' => true,
            'message' => 'kalibrasi untuk berat dihidupkan',
        ]);
    }

    function kalibrasiBeratOff($id): Response
    {
        $perangkat = PerangkatUser::find($id);

        $perangkat->update(['kalibrasi_berat_on' => false]);

        return Response([
            'success' => true,
            'message' => 'kalibrasi untuk berat dimatikan',
        ]);
    }

    function updateKalibrasi(Request $req): Response
    {
        $req->validate([
            'tipe' => 'required|in:tinggi',
            'nomor_serial' => 'required',
        ]);

        if ($req->tipe == 'tinggi') {
            $data = $req->validate([
                'kalibrasi_tinggi' => 'required',
            ]);
        } else if ($req->tipe == 'berat') {
            $data = $req->validate([
                'kalibrasi_berat' => 'required',
            ]);
        }

        $perangkat = PerangkatUser::where('nomor_serial', $req->nomor_serial)->orWhere('nomor_serial_tinggi', $req->nomor_serial)->first();

        if (!$perangkat) {
            return Response([
                'success' => false,
                'message' => "perangkat belum terdaftar"
            ], 400);
        }

        $perangkat->update($data);

        return Response([
            'success' => true,
            'message' => "nilai kalibrasi sensor berhasil diedit",
        ]);
    }

    function destroy($id): Response
    {
        DataRealtime::where('perangkat_id', $id)->delete();
        PerangkatUser::destroy($id);

        return Response([
            'success' => true,
            'message' => 'data perangkat berhasil dihapus',
        ]);
    }

    function getByUserId($userId): Response
    {
        $perangkat = PerangkatUser::where('user_id', $userId)->first();

        if (!$perangkat) {
            return Response([
                'success' => false,
                'message' => 'data perangkat tidak ditemukan'
            ], 400);
        }

        return Response([
            'success' => true,
            'data' => $perangkat,
        ]);
    }

    function getBySerialNumber($nomorSerial): Response
    {
        $perangkat = PerangkatUser::where('nomor_serial', $nomorSerial)->orWhere('nomor_serial_tinggi', $nomorSerial)->first();

        if (!$perangkat) {
            return Response([
                'success' => false,
                'message' => 'data perangkat tidak ditemukan'
            ], 400);
        }

        return Response($perangkat);
    }

    private function validate(Request $req): array
    {
        return $req->validate([
            'nomor_serial' => 'required',
            'user_id' => 'required',
            'nomor_serial_tinggi' => 'nullable',
        ]);
    }
}
