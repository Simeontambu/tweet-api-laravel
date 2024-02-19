<?php

use App\Http\Controllers\API\TweetController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::get('tweets', [TweetController::class, 'index']);


// Create a new user route 
Route::post('user/create', [UserController::class, 'register']);
Route::post('user/login', [UserController::class, 'login']);

Route::middleware('auth:sanctum')->group(function(){

    //user connected
   Route::get('/user', function (Request $request) {
        return $request->user();
        });
//Create post
        Route::post('tweets/create', [TweetController::class, 'store']);
});
