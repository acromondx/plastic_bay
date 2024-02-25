enum PlasticType {
  pet('Polyethylene Terephthalate'),
  pvc('Polyvinyl Chloride'),
  ldpe('Low-Density Polyethylene'),
  pp('Polypropylene'),
  ps('Polystyrene');

  final String name;
  const PlasticType(this.name);
}


PlasticType plasticFromStringToType(String text)=>switch(text){
  'Polyethylene Terephthalate'=> PlasticType.pet,
  'Polyvinyl Chloride'=> PlasticType.pvc,
  'Low-Density Polyethylene'=> PlasticType.ldpe,
  'Polypropylene'=> PlasticType.pp,
  'Polystyrene'=>PlasticType.ps,
  _=> PlasticType.pet,
};