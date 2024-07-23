<?php

use App\Http\Controllers\UsersController;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::middleware(['auth:sanctum'])->group(function () {
    Route::resource('/users', UsersController::class);
});

Route::post('/sanctum/token', function (Request $request) {
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

    return $user->createToken($request->device_name)->plainTextToken;
});
