<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Payment extends Model
{
    use HasFactory;

    protected $fillable = [
        'person_id',
        'type',
        'amount',
        'paid_at',
    ];

    public function person(): BelongsTo
    {
        return $this->belongsTo(Person::class);
    }
}
