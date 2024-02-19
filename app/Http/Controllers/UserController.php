<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginTweetRequest;
use App\Http\Requests\UserTweetRequest;
use App\Models\User;
use Exception;

class UserController extends Controller
{
    public function register(UserTweetRequest $request)
    {
        try {

            $user = new User();
            $user->name = $request->name;
            $user->email = $request->email;
            $user->password = $request->password;
            $user->save();
            return response()->json(
                [
                    'status_code' => 200,
                    'status_message' => "L'utilisateur a été ajouté",
                    'data' => $user
                ]
            );
        } catch (Exception $e) {
            return response()->json($e);
        }
    }

    public function login(LoginTweetRequest $request)
    {
        if (auth()->attempt($request->only(['email', 'password']))) {
            $user = auth()->user();
            $UserToken = $user->createToken('simeontambu')->plainTextToken;
            return response()->json(
                [
                    'status_code' => 200,
                    'status_message' => 'Utilisateur connecter',
                    'user' => $user,
                    'token' => $UserToken
                ]
            );
        } else {
            return response()->json(
                [
                    'status_code' => 403,
                    'status_message' => 'Les informations fourni ne correspond à aucun utilisateur'
                ]
            );
        }
    }
}
