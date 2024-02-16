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
        Schema::create('tweets', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('content');
            $table->integer('comments');
            $table->integer('retweets');
            $table->integer('likes');
            $table->date('dateOrTime');
            $table->string('author');
            $table->string('profileUser');
            $table->boolean('isLiked');
            $table->string('biography');
            $table->string('city');
            $table->string('websiteLink');
            $table->string('yearJoined');
            $table->integer('numberSubscriptions');
            $table->integer('numberSubscribers');
            $table->string('coverPhoto');
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tweets');
    }
};
