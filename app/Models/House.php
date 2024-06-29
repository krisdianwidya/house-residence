<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;

class House extends Model
{
    use HasFactory;

    protected $fillable = [
        'house_number',
        'is_active',
    ];

    public function persons(): HasMany
    {
        return $this->hasMany(Person::class);
    }

    public function payments(): HasManyThrough
    {
        return $this->hasManyThrough(Payment::class, Person::class);
    }
}
