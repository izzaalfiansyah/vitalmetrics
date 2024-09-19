<?php

namespace App\Http\Controllers;

use App\Models\User;
use Hash;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    function login(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required',
            'device_name' => 'required',
        ]);

        $user = User::where('username', $request->username)->orWhere('email', $request->username)->first();

        if (!$user) {
            throw ValidationException::withMessages([
                'username' => 'username tidak ditemukan',
            ]);
        }

        if (!Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'password' => 'password salah',
            ]);
        }

        return [
            'success' => true,
            'message' => 'berhasil login',
            'token' => $user->createToken($request->device_name)->plainTextToken
        ];
    }

    function register(Request $req)
    {
        $userController = new UsersController;
        return $userController->store($req);
    }

    function logout(Request $req)
    {
        $req->user()->currentAccessToken()->delete();

        return [
            'success' => true,
            'message' => 'berhasil logout',
        ];
    }
}
