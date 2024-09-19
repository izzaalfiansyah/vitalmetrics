<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\DataPengukuranController;
use App\Http\Controllers\DataRealtimeController;
use App\Http\Controllers\MenuMakananController;
use App\Http\Controllers\PerangkatUserController;
use App\Http\Controllers\UsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/perangkat_user/by_user_id/{userId}', [PerangkatUserController::class, 'getByUserId']);
    Route::get('/measurement/laporan', [DataPengukuranController::class, 'getLaporan']);
    Route::get('/realtime/by_perangkat_id/{perangkatId}', [DataRealtimeController::class, 'getByPerangkatId']);
    Route::get('/menu_makanan/by_pengukuran_id/{pengukuranId}', [MenuMakananController::class, 'getByPengukuranId']);
    Route::get('/users/count', [UsersController::class, 'count']);
    Route::post('/perangkat_user/{id}/kalibrasi_tinggi_on', [PerangkatUserController::class, 'kalibrasiTinggiOn']);
    Route::post('/perangkat_user/{id}/kalibrasi_tinggi_off', [PerangkatUserController::class, 'kalibrasiTinggiOff']);
    Route::post('/perangkat_user/{id}/kalibrasi_berat_on', [PerangkatUserController::class, 'kalibrasiBeratOn']);
    Route::post('/perangkat_user/{id}/kalibrasi_berat_off', [PerangkatUserController::class, 'kalibrasiBeratOff']);

    Route::resource('/users', UsersController::class);
    Route::resource('/perangkat_user', PerangkatUserController::class);
    Route::resource('/measurement', DataPengukuranController::class);
    Route::resource('/menu_makanan', MenuMakananController::class);
});

Route::get('/perangkat_user/by_serial_number/{nomorSerial}', [PerangkatUserController::class, 'getBySerialNumber']);
Route::post('/perangkat_user/kalibrasi', [PerangkatUserController::class, 'updateKalibrasi']);
Route::post('/realtime', [DataRealtimeController::class, 'create']);
Route::get('/categories', [CategoryController::class, 'index']);