<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\CreateTweetRequest;
use App\Models\Tweet;
use Illuminate\Http\Request;

class TweetController extends Controller
{
    public function index(){
        return Tweet::all();
    }
    public function store(CreateTweetRequest $request){
        $tweet = new Tweet();
        $tweet->name= $request->name;
        $tweet->content= $request->content;
        $tweet->comments= $request->comments;
        $tweet->retweets= $request->retweets;
        $tweet->likes= $request->likes;
        $tweet->dateOrTime= $request->dateOrTime;
        $tweet->author= $request->author;
        $tweet->profileUser= $request->profileUser;
        $tweet->isLiked= $request->isLiked;
        $tweet->biography= $request->biography;
        $tweet->city= $request->city;
        $tweet->websiteLink= $request->websiteLink;
        $tweet->yearJoined= $request->yearJoined;
        $tweet->numberSubscriptions= $request->numberSubscriptions;
        $tweet->numberSubscribers= $request->numberSubscribers;
        $tweet->coverPhoto= $request->coverPhoto;
        $tweet->save();
    }
}
