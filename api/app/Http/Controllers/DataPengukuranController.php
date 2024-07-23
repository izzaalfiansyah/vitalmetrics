<?php

namespace App\Http\Controllers;

use App\Models\DataPengukuran;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class DataPengukuranController extends Controller
{
    function index(): Response
    {
        $data = DataPengukuran::paginate(10);

        return Response([
            'success' => true,
            'message' => 'data pengukuran berhasil diambil',
            'data' => $data,
        ]);
    }

    function show($id): Response
    {
        $data = DataPengukuran::find($id);

        if (!$data) {
            return Response([
                'success' => false,
                'message' => 'data pengukuran tidak diketahui',
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data pengukuran berhasil diambil',
            'data' => $data,
        ]);
    }

    function store(Request $req): Response
    {
        $data = $this->validate($req);

        if (!DataPengukuran::create($data)) {
            return Response([
                'success' => false,
                'message' => 'data pengukuran gagal ditambah',
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data pengukuran berhasil ditambah',
        ]);
    }

    function update(Request $req, $id): Response
    {
        $pengukuran = DataPengukuran::find($id);

        if (!$pengukuran) {
            return Response([
                'success' => false,
                'message' => 'data pengukuran tidak diketahui',
            ], 400);
        }

        $data = $this->validate($req);

        if (!$pengukuran->update($data)) {
            return Response([
                'success' => false,
                'message' => 'data pengukuran gagal disimpan',
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data pengukuran berhasil disimpan',
        ]);
    }

    function destroy($id): Response
    {
        DataPengukuran::destroy(
            $id
        );

        return Response([
            'success' => true,
            'message' => 'data pengukuran berhasil dihapus'
        ]);
    }

    function getLatest(): Response
    {
        $pengukuran = DataPengukuran::limit(2)->orderBy('created_at', 'desc')->get();

        return Response([
            'success' => true,
            'message' => 'data pengukuran terakhir berhasil diambil',
            'data' => $pengukuran,
        ]);
    }

    private function validate($req)
    {
        return $req->validate([
            'user_id' => 'required',
            'user_umur' => 'required|integer',
            'perangkat_id' => 'required',
            'berat' => 'required|decimal:1,3',
            'tinggi' => 'required|decimal:1,3',
        ]);
    }
}
