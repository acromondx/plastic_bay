enum PlasticStatus{
  pending,
  review,
  accepted,
  rejected,
  pickedUp,
}

PlasticStatus plasticFromStringToStatus(String text)=>switch(text){
  'pending'=> PlasticStatus.pending,
  'accepted'=> PlasticStatus.accepted,
  'review'=> PlasticStatus.review,
  'rejected'=> PlasticStatus.rejected,
  'pickedUp'=>PlasticStatus.pickedUp,
  _=> PlasticStatus.pending,
};