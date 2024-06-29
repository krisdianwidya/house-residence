<?php

namespace App\Http\Controllers\Api;

use App\Models\Payment;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\GeneralResource;
use Illuminate\Support\Facades\Validator;

class PaymentController extends Controller
{
    public function index()
    {
        // get all payments
        $payments = Payment::all();

        // return collection of payments
        return new GeneralResource(true, 'Payemnts List', $payments);
    }

    public function store(Request $request)
    {

        // define validation rules
        $validator = Validator::make($request->all(), [
            'person_id' => 'required|exists:people,id',
            'type' => 'required|string',
            'bill_for' => 'required|date',
            'amount' => 'required|numeric',
            'paid_at' => 'required|date',
        ]);

        // check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // create payment
        $payment = Payment::create($request->all());

        // return response
        return new GeneralResource(true, 'Payment added!', $payment);
    }

    public function show($id)
    {
        // find payment by ID
        $payment = Payment::find($id);

        // return single payment as a resource
        return new GeneralResource(true, 'Payment detail', $payment);
    }

    public function update(Request $request, $id)
    {

        // define validation rules
        $validator = Validator::make($request->all(), [
            'person_id' => 'required|exists:people,id',
            'type' => 'required|string',
            'bill_for' => 'required|date',
            'amount' => 'required|numeric',
            'paid_at' => 'required|date',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // find payment by id
        $payment = Payment::find($id);

        // update payment
        $payment->update($request->all());

        // return response
        return new GeneralResource(true, 'Payment updated!', $payment);
    }

    public function destroy($id)
    {

        // find payment by id
        $payment = Payment::find($id);

        // delete payment
        $payment->delete();

        // return response
        return new GeneralResource(true, 'Payment deleted!', null);
    }
}
