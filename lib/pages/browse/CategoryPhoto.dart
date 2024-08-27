
class Category{


  int id;
  String imagePath;
  String?name;

Category({required this.id,required this.imagePath, this.name=""});
  static List<Category> getCategory(){
    return[
     Category(id:1 , imagePath: "assets/images/action.jpg"),
      Category(id:2 , imagePath: "assets/images/adventure.jpeg",),
      Category(id:3 , imagePath: "assets/images/Animation.jpg"),
      Category(id:4 , imagePath: "assets/images/comedy.jpeg"),
      Category(id:5 , imagePath: "assets/images/crime.jpg"),
      Category(id:6 , imagePath: "assets/images/Doc.jpg"),
      Category(id:7 , imagePath: "assets/images/drama.jpg"),
      Category(id:8 , imagePath: "assets/images/family.jpg"),
      Category(id:9 , imagePath: "assets/images/fantasty.jpeg"),
      Category(id:10 , imagePath: "assets/images/History.jpg"),
      Category(id:11 , imagePath: "assets/images/Horr.jpg"),
      Category(id:12 , imagePath: "assets/images/music.jpg"),
      Category(id:13 , imagePath: "assets/images/myster.jpg"),
      Category(id:14 , imagePath: "assets/images/rom.webp"),
      Category(id:15 , imagePath: "assets/images/science.webp"),
      Category(id:16 , imagePath: "assets/images/thriller.jpeg"),
      Category(id:17 , imagePath: "assets/images/TV.jpeg"),
      Category(id:18 , imagePath: "assets/images/war.jpeg"),
      Category(id:19 , imagePath: "assets/images/western.jpg"),




    ];
  }



}