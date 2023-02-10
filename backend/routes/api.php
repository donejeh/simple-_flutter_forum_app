<?php

use App\Http\Controllers\Auth\AuthenticationController;
use App\Http\Controllers\Feed\FeedController;
use App\Models\Feed;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('register', [AuthenticationController::class, 'register']);
Route::post('login', [AuthenticationController::class, 'login']);

Route::middleware(['auth:sanctum'])->group(function () {
    
Route::get('/feeds', [FeedController::class, 'index']);
Route::post('/feed/store', [FeedController::class, 'store']);

//like feed
Route::post('/feed/like/{id}', [FeedController::class, 'likePost']);

//comment on feed
Route::post('/feed/comment/{id}', [FeedController::class, 'comment']);
Route::get('/feed/comments/{id}', [FeedController::class, 'getAllcomments']);


});

