<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            'username' => 'izzaalfiansyah',
            'email' => 'iansyah724@gmail.com',
            'password' => '12345678',
            'nama' => 'Muhammad Izza Alfiansyah',
            'tanggal_lahir' => '2024-02-07',
            'jenis_kelamin' => 'l',
        ]);
    }
}
