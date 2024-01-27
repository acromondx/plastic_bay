enum PostStatus{
  pending,
  review,
  accepted,
  rejected,
}

PostStatus fromStringToStatus(String text)=>switch(text){
  'pending'=> PostStatus.pending,
  'accepted'=> PostStatus.accepted,
  'review'=> PostStatus.review,
  'rejected'=> PostStatus.rejected,
  _=> PostStatus.pending,
};