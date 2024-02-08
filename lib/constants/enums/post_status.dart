enum PostStatus{
  pending,
  review,
  accepted,
  rejected,
  pickedUp,
}

PostStatus fromStringToStatus(String text)=>switch(text){
  'pending'=> PostStatus.pending,
  'accepted'=> PostStatus.accepted,
  'review'=> PostStatus.review,
  'rejected'=> PostStatus.rejected,
  'pickedUp'=>PostStatus.pickedUp,
  _=> PostStatus.pending,
};