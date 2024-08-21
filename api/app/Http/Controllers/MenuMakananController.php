<?php

namespace App\Http\Controllers;

use App\Models\MenuMakanan;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class MenuMakananController extends Controller
{
    public function index(Request $req): Response
    {
        $builder = new MenuMakanan();

        if ($req->umur) {
            $builder = $builder->where('umur_min', '<=', $req->umur)->where('umur_max', '>=', $req->umur);
        } else {
            if ($req->umur_min) {
                $builder = $builder->where('umur_min', $req->umur_min);
            }
            if ($req->umur_max) {
                $builder = $builder->where('umur_max', $req->umur_max);
            }
        }

        $data = $builder->get();

        return Response([
            'success' => true,
            'message' => 'data menu makanan berhasil di ambil',
            'data' => $data,
        ]);
    }

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
