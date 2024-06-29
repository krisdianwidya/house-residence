<?php

namespace App\Http\Controllers\Api;

use App\Models\House;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\HouseResource;

class HouseController extends Controller
{
    public function index()
    {
        $houses = House::latest()->paginate(5);
        return new HouseResource(true, 'Houses List', $houses);
    }
}
