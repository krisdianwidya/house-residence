<?php

namespace App\Http\Controllers\Api;

use App\Models\Person;
use App\Http\Controllers\Controller;
use App\Http\Resources\GeneralResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Database\Eloquent\Builder;

class PersonController extends Controller
{
    public function index(Request $request)
    {
        // define query param value
        $page = $request->input('page', 1);
        $limit = $request->input('limit', 10);
        $sort = $request->input('sort', 'created_at');
        $order = $request->input('order', 'asc');
        $houseId = $request->input('house-id');

        // get all people
        $people = Person::with(['house'])
            ->when($houseId, function (Builder $query, $houseId) {
                $query->where('house_id', '=', $houseId);
            })
            ->orderBy($sort, $order)
            ->paginate($limit, ['*'], 'page', $page);

        // return collection of people
        return new GeneralResource(true, 'People List', $people);
    }

    public function store(Request $request)
    {

        // define validation rules
        $validator = Validator::make($request->all(), [
            'full_name' => 'required|string',
            'id_card_photo' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
            'is_full' => 'required|boolean',
            'phone_number' => 'required|string',
            'married_status' => 'required|string',
            'house_id' => 'required|exists:houses,id',
        ]);

        // check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        //upload idCardPhoto
        $idCardPhoto = $request->file('id_card_photo');
        $idCardPhoto->storeAs('public/id_cards', $idCardPhoto->hashName());

        // create person
        $person = Person::create([...$request->all(), 'id_card_photo' => $idCardPhoto->hashName()]);

        // return response
        return new GeneralResource(true, 'Person added!', $person);
    }

    public function show($id)
    {
        // find person by ID
        $person = Person::with(['house'])->find($id);

        // return single person as a resource
        return new GeneralResource(true, 'Person detail', $person);
    }

    public function update(Request $request, $id)
    {

        // define validation rules
        $validator = Validator::make($request->all(), [
            'full_name' => 'required|string',
            'is_full' => 'required',
            'phone_number' => 'required|string',
            'married_status' => 'required|string',
            'house_id' => 'required|exists:houses,id',
        ]);

        // check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // find person by id
        $person = Person::find($id);

        // file handling
        if ($request->hasFile('id_card_photo')) {

            // upload idCardPhoto
            $idCardPhoto = $request->file('id_card_photo');
            $idCardPhoto->storeAs('public/id_cards', $idCardPhoto->hashName());

            // delete old idCardPhoto
            Storage::delete('public/id_cards/' . basename($person->id_card_photo));

            // update person with new idCardPhoto
            $person->update([...$request->all(), 'id_card_photo' => $idCardPhoto->hashName()]);
        } else {
            // update person without id_card_photo
            $person->update([
                'full_name' => $request->full_name,
                'is_full' => $request->is_full,
                'phone_number' => $request->phone_number,
                'married_status' => $request->married_status,
                'house_id' => $request->house_id,
            ]);
        }

        // return response
        return new GeneralResource(true, 'Person updated!', $person);
    }

    public function destroy($id)
    {
        // find person by id
        $person = Person::find($id);

        // delete person
        $person->delete();

        // return response
        return new GeneralResource(true, 'Person deleted!', null);
    }
}
