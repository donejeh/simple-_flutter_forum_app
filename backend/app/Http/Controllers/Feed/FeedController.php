<?php

namespace App\Http\Controllers\Feed;

use App\Models\Feed;
use App\Models\Like;
use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use App\Http\Requests\Feed\FeedRequest;

class FeedController extends Controller
{

    public function index()
    {

        $feed = Feed::with('user')->latest()->get();

        return response(
            [
                'feed' => $feed

            ],
            200
        );
    }
    
    /**
     * store
     *
     * @param  mixed $request
     * @return void
     */
    public function store(FeedRequest $request)
    {
        $request->validated();

        auth()->user()->feeds()->create(['content' => $request->content]);

        return response([
            'message' => "success",
        ], 201);
    }


    /**
     * likePost
     *
     * @param  mixed $feed_id
     * @return void
     */
    public function likePost($feed_id)
    {

        //select feed with feed_id
        // $feed = Feed::whereId($feed_id)->first();
        $feed = Feed::find($feed_id);

        if (!$feed) {

            return response([
                'message' => 'Not found',
            ], 404);
        }

        $unlike_post = Like::where('user_id', auth()->id())->where('feed_id', $feed_id)->delete();

        if ($unlike_post) {

            return response([
                'message' => 'UnLiked',
            ], 200);
        } else {

            Like::create([
                'user_id' => auth()->id(),
                'feed_id' => $feed_id
            ]);

            return response([
                'message' => 'Liked',
            ], 201);
        }
    }

    /**
     * comment
     *
     * @param  mixed $request
     * @param  mixed $feed_id
     * @return void
     */
    public function comment(Request $request, $feed_id)
    {

        Log::info($feed_id);
        $request->validate([
            'body' => 'required'
        ]);

        $comment = Comment::create([
            'user_id' => auth()->id(),
            'feed_id' => $feed_id,
            'body' => $request->body,
        ]);

        return response([
            'message' => 'success',
            'comment' => $comment
        ], 200);
    }
    
    /**
     * getAllComments
     *
     * @param  mixed $feed_id
     * @return void
     */
    public function getAllComments($feed_id){
        $comment = Comment::with(['feed','user'])->whereFeedId($feed_id)->latest()->get();

        return response([
            'message'=> 'success',
            'comments'=> $comment,
        ], 200);
    }
}
