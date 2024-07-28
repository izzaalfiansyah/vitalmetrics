<?php

use App\Http\Controllers\DataPengukuranController;
use App\Http\Controllers\DataRealtimeController;
use App\Http\Controllers\PerangkatUserController;
use App\Http\Controllers\UsersController;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/perangkat_user/by_user_id/{userId}', [PerangkatUserController::class, 'getByUserId']);
    Route::get('/measurement/laporan', [DataPengukuranController::class, 'getLaporan']);
    Route::get('/realtime/by_perangkat_id/{perangkatId}', [DataRealtimeController::class, 'getByPerangkatId']);

    Route::resource('/users', UsersController::class);
    Route::resource('/perangkat_user', PerangkatUserController::class);
    Route::resource('/measurement', DataPengukuranController::class);
});

Route::post('/realtime', [DataRealtimeController::class, 'create']);

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

    return [
        'success' => true,
        'message' => 'berhasil login',
        'token' => $user->createToken($request->device_name)->plainTextToken
    ];
});

Route::post('/sanctum/destroy', function (Request $req) {
    $req->user()->currentAccessToken()->delete();

    return [
        'success' => true,
        'message' => 'berhasil logout',
    ];
})->middleware('auth:sanctum');
