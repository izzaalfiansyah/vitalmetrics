<?php

namespace App\Http\Controllers;

use App\Models\DataPengukuran;
use App\Models\MenuMakanan;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class MenuMakananController extends Controller
{
    public function index(): Response
    {
        $data = MenuMakanan::all();
        return Response([
            'success' => true,
            'message' => 'data menu makanan berhasil di ambil',
            'data' => $data,
        ]);
    }

    // public function getByPengukuranId(Request $req, $pengukuranId): Response
    // {
    //     $pengukuran = DataPengukuran::find($pengukuranId);

    //     return Response();
    // }

    public function store(Request $req): Response
    {
        $data = $this->validate($req);

        $isSaved = MenuMakanan::create($data);

        if (!$isSaved) {
            return Response([
                'success' => false,
                'message' => 'menu makanan gagal ditambah'
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data menu makanan berhasil ditambah',
        ]);
    }

    public function destroy($id): Response
    {
        MenuMakanan::destroy($id);

        return Response([
            'success' => true,
            'message' => 'data berhasil dihapus',
        ]);
    }

    private function validate(Request $req)
    {
        return $req->validate([
            'waktu' => 'required|in:1,2,3,4,5',
            'umur_min' => 'required|integer',
            'umur_max' => 'required|integer',
            'nama' => 'required',
            'kategori_gizi' => 'required|in:normal,kurang,lebih',
            'bahan' => 'required',
            'bahan.*' => 'required',
            'bahan.*.nama' => 'required',
            'bahan.*.jumlah_urt' => 'required',
            'bahan.*.berat' => 'required',
            'bahan.*.energi' => 'required',
            'bahan.*.protein' => 'required',
            'bahan.*.lemak' => 'required',
            'bahan.*.kh' => 'required',
        ]);
    }
}
