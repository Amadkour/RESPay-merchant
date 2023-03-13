class Story {
  final int id;
  final String mediaLink;
  final String description;
  final String type;
  final Track? track;
  final String userImage;
  final int likeCount;
  final int saveCount;
  final bool isLiked;
  final bool isSaved;

  Story({
    required this.id,
    required this.mediaLink,
    required this.type,
    required this.description,
    required this.isLiked,
    required this.isSaved,
    required this.likeCount,
    required this.saveCount,
    required this.userImage,
    this.track,
  });

  factory Story.fromJson(Map<String, dynamic> map) {
    return Story(
      id: map['id'] as int,
      description: map['description'].toString(),
      mediaLink: map['media_link'].toString(),
      type: map['type'].toString(),
      isLiked: map['is_liked'] as bool,
      isSaved: map['is_saved'] as bool,
      likeCount: map['like_count'] as int,
      saveCount: map['save_count'] as int,
      userImage: map['user_image'].toString(),
      track: map['track'] != null ? Track.fromJson(map['track'] as Map<String, dynamic>) : null,
    );
  }
}

class Track {
  final String name;
  final String image;
  final String link;

  Track({required this.name, required this.image, required this.link});

  factory Track.fromJson(Map<String, dynamic> map) {
    return Track(
      name: map['name'].toString(),
      image: map['image'].toString(),
      link: map['media_link'].toString(),
    );
  }
}
