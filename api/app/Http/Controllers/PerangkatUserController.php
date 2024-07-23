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
            ]);
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
            ]);
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
            ]);
        }

        $data = $this->validate($req);

        if (!$perangkat->update($data)) {
            return Response([
                'success' => false,
                'message' => 'data perangkat user gagal disimpan',
            ]);
        }

        return Response([
            'success' => true,
            'message' => 'data perangkat user berhasil disimpan',
        ]);
    }

    function delete($id): Response
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
            ]);
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
        ]);
    }
}
