class PersonalityCategory{
  final String id;
  final String name;
  final String info;
  final String image;
  final String status;
  
  PersonalityCategory({
    required this.id,
    required this.name, 
    required this.info,
    required this.image,
    required this.status});

  factory PersonalityCategory.fromJSON(Map < String, dynamic> data){
    return PersonalityCategory(
      id: data['ID'], 
      name: data['name'], 
      info: data['information'],
      image: data['image'], 
      status: data['status']);
  }


}