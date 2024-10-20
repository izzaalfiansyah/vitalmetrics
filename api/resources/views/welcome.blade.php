<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>E-Smart Record</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100..900&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>

    <link rel="apple-touch-icon" href="{{ asset('/logo.png') }}">
    <link rel="icon" href="{{ asset('/logo.png') }}">

    <style>
        * {
            font-family: 'Montserrat', sans-serif;
        }
    </style>

</head>

<body class="antialiased">
    <div class="bg-gray-100 bg-opacity-5 min-h-screen flex items-center justify-center p-5">
        <div class="space-y-10 flex items-center flex-col">
            <div class="space-y-5 flex items-center flex-col">
                <img src="{{ asset('/logo.png') }}" alt="" class="rounded-xl">
                <div class="font-semibold text-center">E-Smart Record</div>
                <p class="text-center">aplikasi untuk kalkulasi dan pencatatan kesehatan.</p>
            </div>
            <a href="{{ asset('/e-smart-record.apk') }}" target="_blank" download
                class="border-[#E91E62] border bg-transparent rounded-full px-8 py-2.5 text-[#E91E62]">Download Di
                Sini</a>
        </div>
    </div>
</body>

</html>
