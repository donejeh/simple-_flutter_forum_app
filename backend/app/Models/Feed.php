<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Hash;

class Feed extends Model
{
    use HasFactory;

    protected $fillable =[
        'user_id',
        'content'
    ];
    
    /**
     * appends
     *
     * @var array
     */
    protected $appends = ['liked'];
    
    /**
     * user
     *
     * @return BelongsTo
     */
    public function user(): BelongsTo{
        return $this->belongsTo(User::class);
    }
    
    /**
     * likes
     *
     * @return HasMany
     */
    public function likes(): HasMany{
        return $this->hasMany(Like::class);
    }
    
    /**
     * comments
     *
     * @return HasMany
     */
    public function comments(): HasMany{
        return $this->hasMany(Comment::class);
    }
    
    
    /**
     * getLikedAttribute
     *
     * @return bool
     */
    public function getLikedAttribute(): bool{
        return (bool) $this->likes()->where('feed_id',$this->id)->where('user_id',auth()->id())->exists();
    }

    
}
