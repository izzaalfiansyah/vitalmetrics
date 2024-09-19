<?php

namespace App\Http\Controllers;

use App\Models\DataPengukuran;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class DataPengukuranController extends Controller
{
    function index(Request $req): Response
    {
        $limit = $req->limit ?: 10;

        $builder = DataPengukuran::orderBy('created_at', 'desc');

        if ($req->has('user_id')) {
            $builder = $builder->where('user_id', $req->user_id);
        }

        $data = $builder->paginate($limit);

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

        $user = User::find($req->user_id);

        $data['user_umur'] = $user->umur;
        $data['user_bulan'] = $user->umur_bulan;

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

    function getLaporan(Request $req): Response
    {
        $builder = new DataPengukuran;

        $time_format = "%d/%m/%y";

        if (!!$req->tipe) {
            if ($req->tipe == 'mingguan') {
                $time_format = "%u/%y";
            } else if ($req->tipe == 'bulanan') {
                $time_format = "%m/%y";
            } else if ($req->tipe == 'tahunan') {
                $time_format = "%Y";
            }
        }

        $builder = $builder->select(
            DB::raw('avg(tinggi) as tinggi'),
            DB::raw('avg(berat) as berat'),
            DB::raw('cast(avg(user_umur) as float) as user_umur'),
            DB::raw("date_format(created_at, '$time_format') as time"),
        );

        if (!!$req->user_id) {
            $builder = $builder->where('user_id', $req->user_id);
            $builder = $builder->addSelect(DB::raw("$req->user_id as user_id"));
        }

        $builder = $builder->groupBy(DB::raw("date_format(created_at, '$time_format')"));

        $builder = $builder->limit(10);

        $data = $builder->get();

        return Response([
            'success' => true,
            'message' => 'laporan harian pengukuran berhasil diambil',
            'data' => $data,
        ]);
    }

    private function validate($req)
    {
        return $req->validate([
            'user_id' => 'required',
            'perangkat_id' => 'required',
            'berat' => 'required',
            'tinggi' => 'required',
        ]);
    }
}
