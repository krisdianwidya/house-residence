<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class House extends Model
{
    use HasFactory;

    protected $fillable = [
        'house_number',
        'is_active',
    ];

    public function persons()
    {
        return $this->hasMany(Person::class);
    }

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }
}
