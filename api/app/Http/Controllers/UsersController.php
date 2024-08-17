<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Password;

class UsersController extends Controller
{
    function index()
    {
        $user = User::paginate(10);

        return Response([
            'success' => true,
            'data' => $user,
            'message' => 'data user berhasil diambil',
        ]);
    }

    function count(): Response
    {
        $total = DB::table('users')->select(DB::raw("count(id) as total"))->first()?->total ?: 0;
        $male_total = DB::table('users')->select(DB::raw("count(id) as total"))->where('jenis_kelamin', 'l')->first()?->total ?: 0;
        $female_total = DB::table('users')->select(DB::raw("count(id) as total"))->where('jenis_kelamin', 'p')->first()?->total ?: 0;

        return Response([
            'success' => true,
            'data' => [
                'total' => $total,
                'male' => $male_total,
                'female' => $female_total,
            ]
        ]);
    }

    function show($id)
    {
        $user = User::find($id);

        return Response([
            'success' => true,
            'message' => 'data user berhasil diambil',
            'data' => $user,
        ]);
    }

    function store(Request $req): Response
    {
        $data = $this->validate($req);

        $user = User::create($data);

        if (!$user) {
            return Response([
                'success' => false,
                'message' => 'data user gagal ditambah',
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data user berhasil ditambah',
        ]);
    }

    function update(Request $req, $id): Response
    {
        $user = User::find($id);

        if (!$user) {
            return Response([
                'success' => false,
                'message' => 'data user tidak ditemukan',
            ], 400);
        }

        $data = $this->validate($req, $user);

        if (!$data['password']) {
            unset($data['password']);
        }

        if (!$user->update($data)) {
            return Response([
                'success' => false,
                'message' => 'data user gagal disimpan',
            ], 400);
        }

        return Response([
            'success' => true,
            'message' => 'data user berhasil disimpan',
        ]);
    }

    private function validate(Request $req, User $user = null): array
    {
        return $req->validate([
            'username' => ['required', $user ? Rule::unique('users')->ignore($user->id) : Rule::unique('users')],
            'email' => ['required', 'email', $user ? Rule::unique('users')->ignore($user->id) : Rule::unique('users')],
            'nama' => 'required',
            'tanggal_lahir' => 'required|date',
            'jenis_kelamin' => 'required|in:l,p',
            'password' => [$user ? 'nullable' : 'required', Password::default(), 'confirmed']
        ]);
    }
}
