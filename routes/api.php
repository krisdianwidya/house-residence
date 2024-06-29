<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\HouseController;

//posts
Route::apiResource('/houses', HouseController::class);
