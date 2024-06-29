<?php

namespace App\Http\Controllers\Api;

use App\Models\House;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\HouseResource;
use Illuminate\Support\Facades\Validator;

class HouseController extends Controller
{
    public function index()
    {
        // get all houses
        $houses = House::with(['persons', 'payments'])->latest()->paginate(5);

        // return collection of houses
        return new HouseResource(true, 'Houses List', $houses);
    }

    public function store(Request $request)
    {

        // define validation rules
        $validator = Validator::make($request->all(), [
            'house_number' => 'required|string',
            'is_active' => 'required|boolean',
        ]);

        // check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // create house
        $house = House::create($request->all());

        // return response
        return new HouseResource(true, 'House added!', $house);
    }

    public function show($id)
    {
        // find house by ID
        $house = House::with(['persons', 'payments'])->find($id);

        // return single house as a resource
        return new HouseResource(true, 'House detail', $house);
    }

    public function update(Request $request, $id)
    {

        // define validation rules
        $validator = Validator::make($request->all(), [
            'house_number' => 'required|string',
            'is_active' => 'required|boolean',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // find house by id
        $house = House::find($id);

        // update house
        $house->update($request->all());

        // return response
        return new HouseResource(true, 'House updated!', $house);
    }

    public function destroy($id)
    {

        // find house by id
        $house = House::find($id);

        // delete house
        $house->delete();

        // return response
        return new HouseResource(true, 'House deleted!', null);
    }
}
