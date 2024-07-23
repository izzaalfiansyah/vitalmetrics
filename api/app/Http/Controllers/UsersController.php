<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Password;

class UsersController extends Controller
{
    function index()
    {
        $user = User::paginate(10);

        return Response([
            'data' => $user,
            'message' => 'data user berhasil diambil',
        ]);
    }

    function store(Request $req): Response
    {
        $this->validate($req);

        $user = User::create($req->validated());

        if (!$user) {
            return Response([
                'success' => false,
                'message' => 'data user gagal ditambah',
            ]);
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
            ]);
        }

        $this->validate($req, $user);

        if (!$user->update($req->validated())) {
            return Response([
                'success' => false,
                'message' => 'data user gagal disimpan',
            ]);
        }

        return Response([
            'success' => true,
            'message' => 'data user berhasil disimpan',
        ]);
    }

    private function validate(Request $req, User $user = null)
    {
        $req->validate([
            'username' => ['required', $user ? Rule::unique('users')->ignore($user->id) : Rule::unique('users')],
            'email' => ['required', 'email', $user ? Rule::unique('users')->ignore($user->id) : Rule::unique('users')],
            'nama' => 'required',
            'tanggal_lahir' => 'required|tanggal_lahir',
            'jenis_kelamin' => 'required|in:l,p',
            'password' => [$user ? 'required' : 'nullable', Password::default(), 'confirmed']
        ]);
    }
}
