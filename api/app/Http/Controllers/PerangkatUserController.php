<?php

namespace App\Http\Controllers;

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

    function destroy($id): Response
    {
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

    private function validate(Request $req): array
    {
        return $req->validate([
            'nomor_serial' => 'required',
            'user_id' => 'required',
            'nomor_serial_tinggi' => 'nullable',
        ]);
    }
}
