import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:unistay/core/constants/app_constants.dart';
import 'package:unistay/core/theme/app_text_styles.dart';
import 'package:unistay/features/home/data/models/hostel_model.dart';
import 'package:unistay/shared/widgets/common_widgets.dart';

/// Hostel details screen with image carousel, amenities, and reviews
class HostelDetailsScreen extends ConsumerStatefulWidget {
  final String hostelId;

  const HostelDetailsScreen({super.key, required this.hostelId});

  @override
  ConsumerState<HostelDetailsScreen> createState() => _HostelDetailsScreenState();
}

class _HostelDetailsScreenState extends ConsumerState<HostelDetailsScreen> {
  int _currentImageIndex = 0;
  final HostelModel _hostel = HostelModel(
    id: '1',
    name: 'Urban Backpackers Hostel',
    description: 'Modern hostel in the heart of the city with excellent amenities and a vibrant community. Perfect for solo travelers and groups alike.',
    address: '123 Main Street',
    city: 'New York',
    country: 'USA',
    latitude: 40.7128,
    longitude: -74.0060,
    images: [
      'https://picsum.photos/800/600?random=1',
      'https://picsum.photos/800/600?random=2',
      'https://picsum.photos/800/600?random=3',
    ],
    pricePerNight: 45.0,
    rating: 4.5,
    reviewCount: 128,
    amenities: ['WiFi', 'Kitchen', 'Lockers', 'Common Room', 'Laundry', '24/7 Reception'],
    rooms: [],
    isVerified: true,
    createdAt: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildImageCarousel()),
          SliverToBoxAdapter(child: _buildContent()),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: _buildBookingBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: AppColors.surface,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.circular),
          ),
          child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.circular),
            ),
            child: const Icon(Icons.favorite_border, color: AppColors.textPrimary),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.circular),
            ),
            child: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildImageCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _hostel.images.length,
          itemBuilder: (context, index, realIndex) {
            return CachedNetworkImage(
              imageUrl: _hostel.images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => Container(
                height: 300,
                color: AppColors.surfaceVariant,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 300,
                color: AppColors.surfaceVariant,
                child: const Icon(Icons.image_not_supported, size: 48),
              ),
            );
          },
          options: CarouselOptions(
            height: 300,
            viewportFraction: 1,
            enlargeCenterPage: false,
            autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() => _currentImageIndex = index);
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _hostel.images.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentImageIndex == entry.key
                    ? AppColors.primary
                    : AppColors.border,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppSpacing.lg),
          _buildDescription(),
          const SizedBox(height: AppSpacing.lg),
          _buildAmenities(),
          const SizedBox(height: AppSpacing.lg),
          _buildReviews(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _hostel.name,
                style: AppTextStyles.heading1,
              ),
            ),
            if (_hostel.isVerified)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.circular),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified, color: AppColors.primary, size: 16),
                    const SizedBox(width: AppSpacing.xs),
                    Text('Verified', style: AppTextStyles.captionSmall.copyWith(color: AppColors.primary)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                '${_hostel.address}, ${_hostel.city}, ${_hostel.country}',
                style: AppTextStyles.caption,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: AppColors.secondary, size: 16),
                  const SizedBox(width: AppSpacing.xs),
                  Text(_hostel.ratingDisplay, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text('(${_hostel.reviewCount} reviews)', style: AppTextStyles.caption),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About', style: AppTextStyles.heading3),
        const SizedBox(height: AppSpacing.sm),
        Text(_hostel.description, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildAmenities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Amenities', style: AppTextStyles.heading3),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _hostel.amenities.map((amenity) {
            return Chip(
              avatar: const Icon(Icons.check_circle_outline, size: 16, color: AppColors.primary),
              label: Text(amenity, style: AppTextStyles.bodySmall),
              backgroundColor: AppColors.surfaceVariant,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews', style: AppTextStyles.heading3),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text('See All', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildReviewItem('John D.', 5.0, 'Great place to stay!', 'Amazing hostel with friendly staff.'),
        const SizedBox(height: AppSpacing.md),
        _buildReviewItem('Sarah M.', 4.0, 'Good value', 'Clean rooms and good location.'),
      ],
    );
  }

  Widget _buildReviewItem(String name, double rating, String title, String comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Text(name[0], style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.secondary, size: 14),
                      const SizedBox(width: AppSpacing.xs),
                      Text(rating.toString(), style: AppTextStyles.captionSmall),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(title, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(height: AppSpacing.xxs),
              Text(comment, style: AppTextStyles.captionSmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookingBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: AppElevation.lg,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price per night', style: AppTextStyles.captionSmall),
                Text(_hostel.priceDisplay, style: AppTextStyles.priceLarge),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 160,
              child: AppButton(
                text: 'Book Now',
                onPressed: () {
                  Navigator.of(context).pushNamed('/booking', arguments: {'hostelId': _hostel.id});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
