<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('people', function (Blueprint $table) {
            $table->id();
            $table->string('fullName');
            $table->string('idCardPhoto')->nullable();
            $table->boolean('isFull')->default(true);
            $table->string('phoneNumber');
            $table->string('marriedStatus');
            $table->foreignId('house_id')->nullable()->constrained('houses')->onDelete('set null');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('people');
    }
};
