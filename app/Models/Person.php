<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;

class Person extends Model
{
    use HasFactory;

    protected $fillable = [
        'full_name',
        'id_card_photo',
        'is_full',
        'phone_number',
        'married_status',
        'house_id'
    ];

    public function house()
    {
        return $this->belongsTo(House::class);
    }

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    protected function idCardPhoto(): Attribute
    {
        return Attribute::make(
            get: fn ($value) => url('/storage/id_cards/' . $value),
        );
    }
}
