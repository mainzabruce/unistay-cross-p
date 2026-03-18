import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unistay/core/constants/app_constants.dart';
import 'package:unistay/core/theme/app_text_styles.dart';
import 'package:unistay/features/home/data/models/hostel_model.dart';
import 'package:unistay/shared/widgets/common_widgets.dart';

/// Home screen widget
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildLocationSelector()),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverToBoxAdapter(child: _buildSectionHeader('Popular Hostels', 'See All')),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: _buildHostelList(),
            ),
            SliverToBoxAdapter(child: _buildSectionHeader('Near You', 'See All')),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: _buildHorizontalHostelList(),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: AppColors.background,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Find your stay', style: AppTextStyles.caption),
          Text('Discover amazing hostels', style: AppTextStyles.heading3),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search hostels, cities...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.circular),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (value) {
          Navigator.of(context).pushNamed('/search', arguments: {'query': value});
        },
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 20),
          const SizedBox(width: AppSpacing.xs),
          Text('New York, USA', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
          const Icon(Icons.keyboard_arrow_down, size: 16),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.home, 'label': 'All'},
      {'icon': Icons.pool, 'label': 'Beach'},
      {'icon': Icons.landscape, 'label': 'Mountain'},
      {'icon': Icons.business_center, 'label': 'City'},
      {'icon': Icons.nights_stay, 'label': 'Cozy'},
    ];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == 0;

          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: isSelected ? AppColors.surface : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  category['label'] as String,
                  style: AppTextStyles.captionSmall.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionLabel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.heading3),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(actionLabel, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildHostelList() {
    // Sample data - replace with actual provider data
    final hostels = _getSampleHostels();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final hostel = hostels[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: HostelCard(hostel: hostel),
          );
        },
        childCount: hostels.length,
      ),
    );
  }

  Widget _buildHorizontalHostelList() {
    final hostels = _getSampleHostels().take(5).toList();

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 240,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          itemCount: hostels.length,
          itemBuilder: (context, index) {
            final hostel = hostels[index];
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: SizedBox(
                width: 180,
                child: HostelCardCompact(hostel: hostel),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
        if (index == 1) {
          Navigator.of(context).pushNamed('/search');
        } else if (index == 3) {
          Navigator.of(context).pushNamed('/profile');
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
        NavigationDestination(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite), label: 'Saved'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
      ],
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
      HostelModel(
        id: '2',
        name: 'Seaside Retreat',
        description: 'Beautiful beachfront accommodation',
        address: '456 Ocean Drive',
        city: 'Miami',
        country: 'USA',
        latitude: 25.7617,
        longitude: -80.1918,
        images: ['https://picsum.photos/400/300?random=2'],
        pricePerNight: 65.0,
        rating: 4.8,
        reviewCount: 256,
        amenities: ['WiFi', 'Pool', 'Beach Access'],
        rooms: [],
        isVerified: true,
        createdAt: DateTime.now(),
      ),
    ];
  }
}

/// Hostel card widget for vertical list
class HostelCard extends StatelessWidget {
  final HostelModel hostel;

  const HostelCard({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () {
        Navigator.of(context).pushNamed('/hostel-details', arguments: hostel.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.sm)),
            child: CachedNetworkImage(
              imageUrl: hostel.primaryImage,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 180,
                color: AppColors.surfaceVariant,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 180,
                color: AppColors.surfaceVariant,
                child: const Icon(Icons.image_not_supported, size: 48),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        hostel.name,
                        style: AppTextStyles.heading3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (hostel.isVerified)
                      const Icon(Icons.verified, color: AppColors.primary, size: 20),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        '${hostel.city}, ${hostel.country}',
                        style: AppTextStyles.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.secondary, size: 18),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          hostel.ratingDisplay,
                          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' (${hostel.reviewCount})',
                          style: AppTextStyles.captionSmall,
                        ),
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
        ],
      ),
    );
  }
}

/// Compact hostel card for horizontal list
class HostelCardCompact extends StatelessWidget {
  final HostelModel hostel;

  const HostelCardCompact({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () {
        Navigator.of(context).pushNamed('/hostel-details', arguments: hostel.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.sm)),
            child: CachedNetworkImage(
              imageUrl: hostel.primaryImage,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 120,
                color: AppColors.surfaceVariant,
              ),
              errorWidget: (context, url, error) => Container(
                height: 120,
                color: AppColors.surfaceVariant,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hostel.name,
                  style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.secondary, size: 14),
                        const SizedBox(width: 2),
                        Text(hostel.ratingDisplay, style: AppTextStyles.captionSmall),
                      ],
                    ),
                    Text(
                      hostel.priceDisplay,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
