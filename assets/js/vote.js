// Function to handle the like button click
function like(postId) {
    var likeCount = parseInt(document.getElementById("likeCount_" + postId).innerHTML);
  
    if (liked[postId]) {
      // User wants to undo the like
      likeCount--;
      delete liked[postId];
    } else {
      // User wants to like
      likeCount++;
      liked[postId] = true;
  
      // If the user has previously disliked, undo the dislike
      if (disliked[postId]) {
        var dislikeCount = parseInt(document.getElementById("dislikeCount_" + postId).innerHTML);
        dislikeCount--;
        delete disliked[postId];
        document.getElementById("dislikeCount_" + postId).innerHTML = dislikeCount;
      }
    }
  
    document.getElementById("likeCount_" + postId).innerHTML = likeCount;
  
    // Call the function to update the likes/dislikes in the database
    updateLikesDislikes(postId, likeCount, dislikeCount);
  }
  
  // Function to handle the dislike button click
  function dislike(postId) {
    var dislikeCount = parseInt(document.getElementById("dislikeCount_" + postId).innerHTML);
  
    if (disliked[postId]) {
      // User wants to undo the dislike
      dislikeCount--;
      delete disliked[postId];
    } else {
      // User wants to dislike
      dislikeCount++;
      disliked[postId] = true;
  
      // If the user has previously liked, undo the like
      if (liked[postId]) {
        var likeCount = parseInt(document.getElementById("likeCount_" + postId).innerHTML);
        likeCount--;
        delete liked[postId];
        document.getElementById("likeCount_" + postId).innerHTML = likeCount;
      }
    }
  
    document.getElementById("dislikeCount_" + postId).innerHTML = dislikeCount;
  
    // Call the function to update the likes/dislikes in the database
    updateLikesDislikes(postId, likeCount, dislikeCount);
  }
  
  // Function to update the likes/dislikes in the database
  function updateLikesDislikes(postId, likeCount, dislikeCount) {
    var xhr = new XMLHttpRequest();
    var url = 'update_likes_dislikes.asp';
    var params = 'postId=' + postId + '&likeCount=' + likeCount + '&dislikeCount=' + dislikeCount;
  
    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  
    xhr.onreadystatechange = function() {
      if (xhr.readyState == 4 && xhr.status == 200) {
        console.log('Likes/Dislikes updated in the database');
      }
    };
  
    xhr.send(params);
  }
  