<?php

namespace App\Http\Controllers\Api;

use App\Models\House;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\GeneralResource;
use Illuminate\Support\Facades\Validator;
use Illuminate\Database\Eloquent\Builder;

class HouseController extends Controller
{
    public function index(Request $request)
    {
        // define query param value
        $page = $request->input('page', 1);
        $limit = $request->input('limit', 10);
        $sort = $request->input('sort', 'house_number');
        $order = $request->input('order', 'asc');
        $houseNumber = $request->input('house-number');

        // get all houses
        $houses = House::with(['persons', 'payments'])
            ->when($houseNumber, function (Builder $query, $houseNumber) {
                $query->where('house_number', 'like', "%{$houseNumber}%");
            })
            ->withCount('persons')
            ->orderBy($sort, $order)
            ->paginate($limit, ['*'], 'page', $page);

        // return collection of houses
        return new GeneralResource(true, 'Houses List', $houses);
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
        return new GeneralResource(true, 'House added!', $house);
    }

    public function show($id)
    {
        // find house by ID
        $house = House::with(['persons', 'payments'])->find($id);

        // return single house as a resource
        return new GeneralResource(true, 'House detail', $house);
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
        return new GeneralResource(true, 'House updated!', $house);
    }

    public function destroy($id)
    {

        // find house by id
        $house = House::find($id);

        // delete house
        $house->delete();

        // return response
        return new GeneralResource(true, 'House deleted!', null);
    }
}
