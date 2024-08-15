<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            'username' => 'admin',
            'email' => 'admin@admin.com',
            'password' => 'admin',
            'nama' => 'Alfiansyah',
            'tanggal_lahir' => '2004-02-07',
            'jenis_kelamin' => 'l',
            'role' => '1',
        ]);
    }
}
