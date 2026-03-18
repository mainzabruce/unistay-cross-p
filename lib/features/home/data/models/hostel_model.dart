import 'package:equatable/equatable.dart';

/// Hostel model representing accommodation data
class HostelModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String address;
  final String city;
  final String country;
  final double latitude;
  final double longitude;
  final List<String> images;
  final double pricePerNight;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  final List<RoomModel> rooms;
  final String? hostName;
  final String? hostImageUrl;
  final bool isVerified;
  final DateTime createdAt;

  const HostelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.pricePerNight,
    required this.rating,
    required this.reviewCount,
    required this.amenities,
    required this.rooms,
    this.hostName,
    this.hostImageUrl,
    required this.isVerified,
    required this.createdAt,
  });

  /// Get the primary image (first in list)
  String get primaryImage => images.isNotEmpty ? images.first : '';

  /// Get price range display
  String get priceDisplay => '\$${pricePerNight.toStringAsFixed(0)}/night';

  /// Get rating display
  String get ratingDisplay => rating.toStringAsFixed(1);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        address,
        city,
        country,
        latitude,
        longitude,
        images,
        pricePerNight,
        rating,
        reviewCount,
        amenities,
        rooms,
        hostName,
        hostImageUrl,
        isVerified,
        createdAt,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'images': images,
      'pricePerNight': pricePerNight,
      'rating': rating,
      'reviewCount': reviewCount,
      'amenities': amenities,
      'rooms': rooms.map((r) => r.toJson()).toList(),
      'hostName': hostName,
      'hostImageUrl': hostImageUrl,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HostelModel.fromJson(Map<String, dynamic> json) {
    return HostelModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      pricePerNight: (json['pricePerNight'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      amenities: List<String>.from(json['amenities'] ?? []),
      rooms: (json['rooms'] as List?)
              ?.map((r) => RoomModel.fromJson(r))
              .toList() ??
          [],
      hostName: json['hostName'],
      hostImageUrl: json['hostImageUrl'],
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}

/// Room model within a hostel
class RoomModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double pricePerNight;
  final int maxGuests;
  final int beds;
  final String bedType;
  final bool hasPrivateBathroom;
  final List<String> images;
  final bool isAvailable;

  const RoomModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerNight,
    required this.maxGuests,
    required this.beds,
    required this.bedType,
    required this.hasPrivateBathroom,
    required this.images,
    required this.isAvailable,
  });

  String get priceDisplay => '\$${pricePerNight.toStringAsFixed(0)}/night';

  String get occupancyDisplay => '$maxGuests guest${maxGuests > 1 ? 's' : ''}';

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pricePerNight,
        maxGuests,
        beds,
        bedType,
        hasPrivateBathroom,
        images,
        isAvailable,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pricePerNight': pricePerNight,
      'maxGuests': maxGuests,
      'beds': beds,
      'bedType': bedType,
      'hasPrivateBathroom': hasPrivateBathroom,
      'images': images,
      'isAvailable': isAvailable,
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pricePerNight: (json['pricePerNight'] ?? 0).toDouble(),
      maxGuests: json['maxGuests'] ?? 1,
      beds: json['beds'] ?? 1,
      bedType: json['bedType'] ?? 'Single',
      hasPrivateBathroom: json['hasPrivateBathroom'] ?? false,
      images: List<String>.from(json['images'] ?? []),
      isAvailable: json['isAvailable'] ?? true,
    );
  }
}

/// Review model for hostel reviews
class ReviewModel extends Equatable {
  final String id;
  final String hostelId;
  final String userId;
  final String userName;
  final String? userImageUrl;
  final double rating;
  final String comment;
  final DateTime createdAt;

  const ReviewModel({
    required this.id,
    required this.hostelId,
    required this.userId,
    required this.userName,
    this.userImageUrl,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        hostelId,
        userId,
        userName,
        userImageUrl,
        rating,
        comment,
        createdAt,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hostelId': hostelId,
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      hostelId: json['hostelId'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userImageUrl: json['userImageUrl'],
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
