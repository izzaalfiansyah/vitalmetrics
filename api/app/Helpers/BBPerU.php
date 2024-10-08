<?php // Code within app\Helpers\Helper.php

namespace App\Helpers;

class BBPerU
{
    public static function sd0Until60Month(bool $male = false)
    {
        if ($male) {
            return [
                [
                    'min' => 0,
                    'data' => [2.1, 2.5, 2.9, 3.3, 3.9, 4.4, 5.0,],
                ],
                [
                    'min' => 1,
                    'data' => [2.9, 3.4, 3.9, 4.5, 5.1, 5.8, 6.6,],
                ],
                [
                    'min' => 2,
                    'data' => [3.8, 4.3, 4.9, 5.6, 6.3, 7.1, 8.0,],
                ],
                [
                    'min' => 3,
                    'data' => [4.4, 5.0, 5.7, 6.4, 7.2, 8.0, 9.0,],
                ],
                [
                    'min' => 4,
                    'data' => [4.9, 5.6, 6.2, 7.0, 7.8, 8.7, 9.7,],
                ],
                [
                    'min' => 5,
                    'data' => [5.3, 6.0, 6.7, 7.5, 8.4, 9.3, 10.4,],
                ],
                [
                    'min' => 6,
                    'data' => [5.7, 6.4, 7.1, 7.9, 8.8, 9.8, 10.9,],
                ],
                [
                    'min' => 7,
                    'data' => [5.9, 6.7, 7.4, 8.3, 9.2, 10.3, 11.4,],
                ],
                [
                    'min' => 8,
                    'data' => [6.2, 6.9, 7.7, 8.6, 9.6, 10.7, 11.9,],
                ],
                [
                    'min' => 9,
                    'data' => [6.4, 7.1, 8.0, 8.9, 9.9, 11.0, 12.3,],
                ],
                [
                    'min' => 10,
                    'data' => [6.6, 7.4, 8.2, 9.2, 10.2, 11.4, 12.7,],
                ],
                [
                    'min' => 11,
                    'data' => [6.8, 7.6, 8.4, 9.4, 10.5, 11.7, 13.0,],
                ],
                [
                    'min' => 12,
                    'data' => [6.9, 7.7, 8.6, 9.6, 10.8, 12.0, 13.3,],
                ],
                [
                    'min' => 13,
                    'data' => [7.1, 7.9, 8.8, 9.9, 11.0, 12.3, 13.7,],
                ],
                [
                    'min' => 14,
                    'data' => [7.2, 8.1, 9.0, 10.1, 11.3, 12.6, 14.0,],
                ],
                [
                    'min' => 15,
                    'data' => [7.4, 8.3, 9.2, 10.3, 11.5, 12.8, 14.3,],
                ],
                [
                    'min' => 16,
                    'data' => [7.5, 8.4, 9.4, 10.5, 11.7, 13.1, 14.6,],
                ],
                [
                    'min' => 17,
                    'data' => [7.7, 8.6, 9.6, 10.7, 12.0, 13.4, 14.9,],
                ],
                [
                    'min' => 18,
                    'data' => [7.8, 8.8, 9.8, 10.9, 12.2, 13.7, 15.3,],
                ],
                [
                    'min' => 19,
                    'data' => [8.0, 8.9, 10.0, 11.1, 12.5, 13.9, 15.6,],
                ],
                [
                    'min' => 20,
                    'data' => [8.1, 9.1, 10.1, 11.3, 12.7, 14.2, 15.9,],
                ],
                [
                    'min' => 21,
                    'data' => [8.2, 9.2, 10.3, 11.5, 12.9, 14.5, 16.2,],
                ],
                [
                    'min' => 22,
                    'data' => [8.4, 9.4, 10.5, 11.8, 13.2, 14.7, 16.5,],
                ],
                [
                    'min' => 23,
                    'data' => [8.5, 9.5, 10.7, 12.0, 13.4, 15.0, 16.8,],
                ],
                [
                    'min' => 24,
                    'data' => [8.6, 9.7, 10.8, 12.2, 13.6, 15.3, 17.1,],
                ],
                [
                    'min' => 25,
                    'data' => [8.8, 9.8, 11.0, 12.4, 13.9, 15.5, 17.5,],
                ],
                [
                    'min' => 26,
                    'data' => [8.9, 10.0, 11.2, 12.5, 14.1, 15.8, 17.8,],
                ],
                [
                    'min' => 27,
                    'data' => [9.0, 10.1, 11.3, 12.7, 14.3, 16.1, 18.1,],
                ],
                [
                    'min' => 29,
                    'data' => [9.2, 10.4, 11.7, 13.1, 14.8, 16.6, 18.7,],
                ],
                [
                    'min' => 28,
                    'data' => [9.1, 10.2, 11.5, 12.9, 14.5, 16.3, 18.4,],
                ],
                [
                    'min' => 30,
                    'data' => [9.4, 10.5, 11.8, 13.3, 15.0, 16.9, 19.0,],
                ],
                [
                    'min' => 31,
                    'data' => [9.5, 10.7, 12.0, 13.5, 15.2, 17.1, 19.3,],
                ],
                [
                    'min' => 32,
                    'data' => [9.6, 10.8, 12.1, 13.7, 15.4, 17.4, 19.6,],
                ],
                [
                    'min' => 33,
                    'data' => [9.7, 10.9, 12.3, 13.8, 15.6, 17.6, 19.9,],
                ],
                [
                    'min' => 34,
                    'data' => [9.8, 11.0, 12.4, 14.0, 15.8, 17.8, 20.2,],
                ],
                [
                    'min' => 35,
                    'data' => [9.9, 11.2, 12.6, 14.2, 16.0, 18.1, 20.4,],
                ],
                [
                    'min' => 36,
                    'data' => [10.0, 11.3, 12.7, 14.3, 16.2, 18.3, 20.7,],
                ],
                [
                    'min' => 37,
                    'data' => [10.1, 11.4, 12.9, 14.5, 16.4, 18.6, 21.0,],
                ],
                [
                    'min' => 38,
                    'data' => [10.2, 11.5, 13.0, 14.7, 16.6, 18.8, 21.3,],
                ],
                [
                    'min' => 39,
                    'data' => [10.3, 11.6, 13.1, 14.8, 16.8, 19.0, 21.6,],
                ],
                [
                    'min' => 40,
                    'data' => [10.4, 11.8, 13.3, 15.0, 17.0, 19.3, 21.9,],
                ],
                [
                    'min' => 41,
                    'data' => [10.5, 11.9, 13.4, 15.2, 17.2, 19.5, 22.1,],
                ],
                [
                    'min' => 42,
                    'data' => [10.6, 12.0, 13.6, 15.3, 17.4, 19.7, 22.4,],
                ],
                [
                    'min' => 43,
                    'data' => [10.7, 12.1, 13.7, 15.5, 17.6, 20.0, 22.7,],
                ],
                [
                    'min' => 44,
                    'data' => [10.8, 12.2, 13.8, 15.7, 17.8, 20.2, 23.0,],
                ],
                [
                    'min' => 45,
                    'data' => [10.9, 12.4, 14.0, 15.8, 18.0, 20.5, 23.3,],
                ],
                [
                    'min' => 46,
                    'data' => [11.0, 12.5, 14.1, 16.0, 18.2, 20.7, 23.6,],
                ],
                [
                    'min' => 47,
                    'data' => [11.1, 12.6, 14.3, 16.2, 18.4, 20.9, 23.9,],
                ],
                [
                    'min' => 48,
                    'data' => [11.2, 12.7, 14.4, 16.3, 18.6, 21.2, 24.2,],
                ],
                [
                    'min' => 49,
                    'data' => [11.3, 12.8, 14.5, 16.5, 18.8, 21.4, 24.5,],
                ],
                [
                    'min' => 50,
                    'data' => [11.4, 12.9, 14.7, 16.7, 19.0, 21.7, 24.8,],
                ],
                [
                    'min' => 51,
                    'data' => [11.5, 13.1, 14.8, 16.8, 19.2, 21.9, 25.1,],
                ],
                [
                    'min' => 52,
                    'data' => [11.6, 13.2, 15.0, 17.0, 19.4, 22.2, 25.4,],
                ],
                [
                    'min' => 53,
                    'data' => [11.7, 13.3, 15.1, 17.2, 19.6, 22.4, 25.7,],
                ],
                [
                    'min' => 54,
                    'data' => [11.8, 13.4, 15.2, 17.3, 19.8, 22.7, 26.0,],
                ],
                [
                    'min' => 55,
                    'data' => [11.9, 13.5, 15.4, 17.5, 20.0, 22.9, 26.3,],
                ],
                [
                    'min' => 56,
                    'data' => [12.0, 13.6, 15.5, 17.7, 20.2, 23.2, 26.6,],
                ],
                [
                    'min' => 57,
                    'data' => [12.1, 13.7, 15.6, 17.8, 20.4, 23.4, 26.9,],
                ],
                [
                    'min' => 58,
                    'data' => [12.2, 13.8, 15.8, 18.0, 20.6, 23.7, 27.2,],
                ],
                [
                    'min' => 59,
                    'data' => [12.3, 14.0, 15.9, 18.2, 20.8, 23.9, 27.6,],
                ],
                [
                    'min' => 60,
                    'data' => [12.4, 14.1, 16.0, 18.3, 21.0, 24.2, 27.9,],
                ],
            ];
        }

        return [
            [
                'min' => 0,
                'data' => [2.0, 2.4, 2.8, 3.2, 3.7, 4.2, 4.8,],
            ],
            [
                'min' => 1,
                'data' => [2.7, 3.2, 3.6, 4.2, 4.8, 5.5, 6.2,],
            ],
            [
                'min' => 2,
                'data' => [3.4, 3.9, 4.5, 5.1, 5.8, 6.6, 7.5,],
            ],
            [
                'min' => 3,
                'data' => [4.0, 4.5, 5.2, 5.8, 6.6, 7.5, 8.5,],
            ],
            [
                'min' => 4,
                'data' => [4.4, 5.0, 5.7, 6.4, 7.3, 8.2, 9.3,],
            ],
            [
                'min' => 5,
                'data' => [4.8, 5.4, 6.1, 6.9, 7.8, 8.8, 10.0,],
            ],
            [
                'min' => 6,
                'data' => [5.1, 5.7, 6.5, 7.3, 8.2, 9.3, 10.6,],
            ],
            [
                'min' => 7,
                'data' => [5.3, 6.0, 6.8, 7.6, 8.6, 9.8, 11.1,],
            ],
            [
                'min' => 8,
                'data' => [5.6, 6.3, 7.0, 7.9, 9.0, 10.2, 11.6,],
            ],
            [
                'min' => 9,
                'data' => [5.8, 6.5, 7.3, 8.2, 9.3, 10.5, 12.0,],
            ],
            [
                'min' => 10,
                'data' => [5.9, 6.7, 7.5, 8.5, 9.6, 10.9, 12.4,],
            ],
            [
                'min' => 11,
                'data' => [6.1, 6.9, 7.7, 8.7, 9.9, 11.2, 12.8,],
            ],
            [
                'min' => 12,
                'data' => [6.3, 7.0, 7.9, 8.9, 10.1, 11.5, 13.1,],
            ],
            [
                'min' => 13,
                'data' => [6.4, 7.2, 8.1, 9.2, 10.4, 11.8, 13.5,],
            ],
            [
                'min' => 14,
                'data' => [6.6, 7.4, 8.3, 9.4, 10.6, 12.1, 13.8,],
            ],
            [
                'min' => 15,
                'data' => [6.7, 7.6, 8.5, 9.6, 10.9, 12.4, 14.1,],
            ],
            [
                'min' => 16,
                'data' => [6.9, 7.7, 8.7, 9.8, 11.1, 12.6, 14.5,],
            ],
            [
                'min' => 17,
                'data' => [7.0, 7.9, 8.9, 10.0, 11.4, 12.9, 14.8,],
            ],
            [
                'min' => 18,
                'data' => [7.2, 8.1, 9.1, 10.2, 11.6, 13.2, 15.1,],
            ],
            [
                'min' => 19,
                'data' => [7.3, 8.2, 9.2, 10.4, 11.8, 13.5, 15.4,],
            ],
            [
                'min' => 20,
                'data' => [7.5, 8.4, 9.4, 10.6, 12.1, 13.7, 15.7,],
            ],
            [
                'min' => 21,
                'data' => [7.6, 8.6, 9.6, 10.9, 12.3, 14.0, 16.0,],
            ],
            [
                'min' => 22,
                'data' => [7.8, 8.7, 9.8, 11.1, 12.5, 14.3, 16.4,],
            ],
            [
                'min' => 23,
                'data' => [7.9, 8.9, 10.0, 11.3, 12.8, 14.6, 16.7,],
            ],
            [
                'min' => 24,
                'data' => [8.1, 9.0, 10.2, 11.5, 13.0, 14.8, 17.0,],
            ],
            [
                'min' => 25,
                'data' => [8.2, 9.2, 10.3, 11.7, 13.3, 15.1, 17.3,],
            ],
            [
                'min' => 26,
                'data' => [8.4, 9.4, 10.5, 11.9, 13.5, 15.4, 17.7,],
            ],
            [
                'min' => 27,
                'data' => [8.5, 9.5, 10.7, 12.1, 13.7, 15.7, 18.0,],
            ],
            [
                'min' => 28,
                'data' => [8.6, 9.7, 10.9, 12.3, 14.0, 16.0, 18.3,],
            ],
            [
                'min' => 29,
                'data' => [8.8, 9.8, 11.1, 12.5, 14.2, 16.2, 18.7,],
            ],
            [
                'min' => 30,
                'data' => [8.9, 10.0, 11.2, 12.7, 14.4, 16.5, 19.0,],
            ],
            [
                'min' => 31,
                'data' => [9.0, 10.1, 11.4, 12.9, 14.7, 16.8, 19.3,],
            ],
            [
                'min' => 32,
                'data' => [9.1, 10.3, 11.6, 13.1, 14.9, 17.1, 19.6,],
            ],
            [
                'min' => 33,
                'data' => [9.3, 10.4, 11.7, 13.3, 15.1, 17.3, 20.0,],
            ],
            [
                'min' => 34,
                'data' => [9.4, 10.5, 11.9, 13.5, 15.4, 17.6, 20.3,],
            ],
            [
                'min' => 35,
                'data' => [9.5, 10.7, 12.0, 13.7, 15.6, 17.9, 20.6,],
            ],
            [
                'min' => 36,
                'data' => [9.6, 10.8, 12.2, 13.9, 15.8, 18.1, 20.9,],
            ],
            [
                'min' => 37,
                'data' => [9.7, 10.9, 12.4, 14.0, 16.0, 18.4, 21.3,],
            ],
            [
                'min' => 38,
                'data' => [9.8, 11.1, 12.5, 14.2, 16.3, 18.7, 21.6,],
            ],
            [
                'min' => 39,
                'data' => [9.9, 11.2, 12.7, 14.4, 16.5, 19.0, 22.0,],
            ],
            [
                'min' => 40,
                'data' => [10.1, 11.3, 12.8, 14.6, 16.7, 19.2, 22.3,],
            ],
            [
                'min' => 41,
                'data' => [10.2, 11.5, 13.0, 14.8, 16.9, 19.5, 22.7,],
            ],
            [
                'min' => 42,
                'data' => [10.3, 11.6, 13.1, 15.0, 17.2, 19.8, 23.0,],
            ],
            [
                'min' => 43,
                'data' => [10.4, 11.7, 13.3, 15.2, 17.4, 20.1, 23.4,],
            ],
            [
                'min' => 44,
                'data' => [10.5, 11.8, 13.4, 15.3, 17.6, 20.4, 23.7,],
            ],
            [
                'min' => 45,
                'data' => [10.6, 12.0, 13.6, 15.5, 17.8, 20.7, 24.1,],
            ],
            [
                'min' => 46,
                'data' => [10.7, 12.1, 13.7, 15.7, 18.1, 20.9, 24.5,],
            ],
            [
                'min' => 47,
                'data' => [10.8, 12.2, 13.9, 15.9, 18.3, 21.2, 24.8,],
            ],
            [
                'min' => 48,
                'data' => [10.9, 12.3, 14.0, 16.1, 18.5, 21.5, 25.2,],
            ],
            [
                'min' => 49,
                'data' => [11.0, 12.4, 14.2, 16.3, 18.8, 21.8, 25.5,],
            ],
            [
                'min' => 50,
                'data' => [11.1, 12.6, 14.3, 16.4, 19.0, 22.1, 25.9,],
            ],
            [
                'min' => 51,
                'data' => [11.2, 12.7, 14.5, 16.6, 19.2, 22.4, 26.3,],
            ],
            [
                'min' => 52,
                'data' => [11.3, 12.8, 14.6, 16.8, 19.4, 22.6, 26.6,],
            ],
            [
                'min' => 53,
                'data' => [11.4, 12.9, 14.8, 17.0, 19.7, 22.9, 27.0,],
            ],
            [
                'min' => 54,
                'data' => [11.5, 13.0, 14.9, 17.2, 19.9, 23.2, 27.4,],
            ],
            [
                'min' => 55,
                'data' => [11.6, 13.2, 15.1, 17.3, 20.1, 23.5, 27.7,],
            ],
            [
                'min' => 56,
                'data' => [11.7, 13.3, 15.2, 17.5, 20.3, 23.8, 28.1,],
            ],
            [
                'min' => 57,
                'data' => [11.8, 13.4, 15.3, 17.7, 20.6, 24.1, 28.5,],
            ],
            [
                'min' => 58,
                'data' => [11.9, 13.5, 15.5, 17.9, 20.8, 24.4, 28.8,],
            ],
            [
                'min' => 59,
                'data' => [12.0, 13.6, 15.6, 18.0, 21.0, 24.6, 29.2,],
            ],
            [
                'min' => 60,
                'data' => [12.1, 13.7, 15.8, 18.2, 21.2, 24.9, 29.5,],
            ],
        ];
    }

    public static function categoriesBySD0Until60Month()
    {
        return [
            'max' => 5,
            'data' => [
                [
                    'min' => -5,
                    'status' => "Berat Badan Sangat Kurang",
                ],
                [
                    'min' => -3,
                    'status' => 'Berat Badan Kurang',
                ],
                [
                    'min' => -2,
                    'status' => 'Berat Badan Normal',
                ],
                [
                    'min' => 1,
                    'status' => 'Resiko Berat Badan Berlebihan',
                ],
            ],
        ];
    }
}