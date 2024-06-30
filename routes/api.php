<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\HouseController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\PersonController;

//posts
Route::apiResource('/houses', HouseController::class);
Route::apiResource('/payments', PaymentController::class);
Route::apiResource('/persons', PersonController::class);
