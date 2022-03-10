
class WarehouseUser {

  String id;
  String username;
  String name;
  String portfolioUrl;
  String bio;
  String location;
  String profileImage;
  int totalLikes;
  int totalPhotos;

  WarehouseUser({
    this.id = "",
    this.username = "",
    this.name = "",
    this.portfolioUrl = "",
    this.bio = "",
    this.location = "",
    this.profileImage = "",
    this.totalLikes = 0,
    this.totalPhotos = 0
  });


  @override
  String toString() {
    return 'WarehouseUser{id: $id, username: $username, name: $name, portfolioUrl: $portfolioUrl, bio: $bio, location: $location, profileImage: $profileImage, totalLikes: $totalLikes, totalPhotos: $totalPhotos}';
  }

  WarehouseUser.fromJSON(Map<String, dynamic> json) :
    id = json["id"],
    username = json["username"] ?? "",
    name = json["name"] ?? "",
    portfolioUrl = json["portfolioUrl"] ?? "",
    bio = json["bio"] ?? "",
    location = json["location"] ?? "",
    profileImage = json["profileImage"] ?? "",
    totalLikes = json["totalLikes"] ?? 0,
    totalPhotos = json["totalPhotos"] ?? 0;

  Map<String, dynamic>  toJSON()=>{
    'id': id,
    'username': username,
    'name': name,
    'portfolioUrl': portfolioUrl,
    'bio': bio,
    'location': location,
    'profileImage': profileImage,
    'totalLikes': totalLikes,
    'totalPhotos': totalPhotos
  };

  WarehouseUser.fromMap(data) :
        id = data["id"] ?? "",
        username = data["username"] ?? "",
        name = data["name"] ?? "",
        portfolioUrl = data["portfolio_url"] ?? "",
        bio = data["bio"] ?? "",
        location = data["location"] ?? "",
        profileImage = data["profile_image"]["medium"] ?? "",
        totalLikes = data["total_likes"] ?? 0,
        totalPhotos = data["total_photos"] ?? 0;


}

