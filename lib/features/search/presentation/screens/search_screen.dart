import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unistay/core/constants/app_constants.dart';
import 'package:unistay/core/theme/app_text_styles.dart';
import 'package:unistay/features/home/data/models/hostel_model.dart';
import 'package:unistay/shared/widgets/common_widgets.dart';

/// Search screen with filters and debounced search
class SearchScreen extends ConsumerStatefulWidget {
  final String? initialQuery;
  final String? initialLocation;

  const SearchScreen({super.key, this.initialQuery, this.initialLocation});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;
  String _selectedPriceRange = 'all';
  int _minRating = 0;
  List<String> _selectedAmenities = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null) {
      _searchController.text = widget.initialQuery!;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(child: _buildResultsList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search hostels...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => setState(() => _showFilters = !_showFilters),
          ),
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.circular),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final amenities = ['WiFi', 'Kitchen', 'Pool', 'Gym', 'Parking'];
    
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: amenities.length,
        itemBuilder: (context, index) {
          final amenity = amenities[index];
          final isSelected = _selectedAmenities.contains(amenity);
          
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterChip(
              label: Text(amenity, style: AppTextStyles.bodySmall),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAmenities.add(amenity);
                  } else {
                    _selectedAmenities.remove(amenity);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultsList() {
    final hostels = _getSampleHostels();
    
    if (hostels.isEmpty) {
      return AppEmptyState(
        icon: Icons.search_off,
        title: 'No hostels found',
        subtitle: 'Try adjusting your search or filters',
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: hostels.length,
      itemBuilder: (context, index) {
        final hostel = hostels[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: HostelSearchCard(hostel: hostel),
        );
      },
    );
  }

  List<HostelModel> _getSampleHostels() {
    return [
      HostelModel(
        id: '1',
        name: 'Urban Backpackers Hostel',
        description: 'Modern hostel in the heart of the city',
        address: '123 Main Street',
        city: 'New York',
        country: 'USA',
        latitude: 40.7128,
        longitude: -74.0060,
        images: ['https://picsum.photos/400/300?random=1'],
        pricePerNight: 45.0,
        rating: 4.5,
        reviewCount: 128,
        amenities: ['WiFi', 'Kitchen', 'Lockers'],
        rooms: [],
        isVerified: true,
        createdAt: DateTime.now(),
      ),
    ];
  }
}

/// Search result card
class HostelSearchCard extends StatelessWidget {
  final HostelModel hostel;

  const HostelSearchCard({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () {
        Navigator.of(context).pushNamed('/hostel-details', arguments: hostel.id);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppRadius.sm)),
            child: CachedNetworkImage(
              imageUrl: hostel.primaryImage,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 120,
                height: 120,
                color: AppColors.surfaceVariant,
              ),
              errorWidget: (context, url, error) => Container(
                width: 120,
                height: 120,
                color: AppColors.surfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hostel.name,
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    hostel.city,
                    style: AppTextStyles.captionSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.secondary, size: 16),
                          const SizedBox(width: AppSpacing.xs),
                          Text(hostel.ratingDisplay, style: AppTextStyles.bodySmall),
                        ],
                      ),
                      Text(
                        hostel.priceDisplay,
                        style: AppTextStyles.price,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
