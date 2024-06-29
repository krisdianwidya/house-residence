<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;

    protected $fillable = [
        'person_id',
        'type',
        'amount',
        'paid_at',
    ];

    public function person()
    {
        return $this->belongsTo(Person::class);
    }
}
