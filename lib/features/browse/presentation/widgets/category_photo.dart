
class Category{


  int id;
  String imagePath;
  String?name;

Category({required this.id,required this.imagePath, this.name=""});
  static List<Category> getCategory(){
    return[
     Category(id:1 , imagePath: "assets/images/action.png"),
      Category(id:2 , imagePath: "assets/images/adventure.png",),
      Category(id:3 , imagePath: "assets/images/animation.png"),
      Category(id:4 , imagePath: "assets/images/comedy.png"),
      Category(id:5 , imagePath: "assets/images/crime.png"),
      Category(id:6 , imagePath: "assets/images/documentary.png"),
      Category(id:7 , imagePath: "assets/images/drama.png"),
      Category(id:8 , imagePath: "assets/images/family.png"),
      Category(id:9 , imagePath: "assets/images/fantasy.png"),
      Category(id:10 , imagePath: "assets/images/history.png"),
      Category(id:11 , imagePath: "assets/images/horror.png"),
      Category(id:12 , imagePath: "assets/images/music.jpg"),
      Category(id:13 , imagePath: "assets/images/mystery.png"),
      Category(id:14 , imagePath: "assets/images/romance.png"),
      Category(id:15 , imagePath: "assets/images/science fiction.png"),
      Category(id:16 , imagePath: "assets/images/thriller.png"),
      Category(id:17 , imagePath: "assets/images/tv movie.png"),
      Category(id:18 , imagePath: "assets/images/war.png"),
      Category(id:19 , imagePath: "assets/images/western.png"),




    ];
  }



}