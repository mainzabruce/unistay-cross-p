import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unistay/core/constants/app_constants.dart';
import 'package:unistay/core/theme/app_text_styles.dart';
import 'package:unistay/shared/widgets/common_widgets.dart';

/// Booking screen with date picker, guest selector, and payment options
class BookingScreen extends StatefulWidget {
  final String hostelId;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int guests;

  const BookingScreen({
    super.key,
    required this.hostelId,
    this.checkIn,
    this.checkOut,
    this.guests = 1,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 1;
  int _rooms = 1;
  String _selectedPaymentMethod = 'card';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkInDate = widget.checkIn ?? DateTime.now().add(const Duration(days: 1));
    _checkOutDate = widget.checkOut ?? DateTime.now().add(const Duration(days: 3));
    _guests = widget.guests;
  }

  Future<void> _selectDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? _checkInDate : _checkOutDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && _checkOutDate!.isBefore(picked)) {
            _checkOutDate = picked.add(const Duration(days: 1));
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  void _adjustGuests(int delta) {
    setState(() {
      _guests = (_guests + delta).clamp(1, 10);
    });
  }

  void _adjustRooms(int delta) {
    setState(() {
      _rooms = (_rooms + delta).clamp(1, 5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Stay'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Select Dates'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildDateSelection(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSectionTitle('Guests & Rooms'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildGuestSelector(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSectionTitle('Payment Method'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildPaymentOptions(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildBookingSummary(),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.heading3);
  }

  Widget _buildDateSelection() {
    return Row(
      children: [
        Expanded(
          child: _buildDateCard(
            title: 'Check-in',
            date: _checkInDate,
            onTap: () => _selectDate(true),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildDateCard(
            title: 'Check-out',
            date: _checkOutDate,
            onTap: () => _selectDate(false),
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard({required String title, DateTime? date, VoidCallback? onTap}) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.captionSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            date != null ? '${date.day}/${date.month}/${date.year}' : 'Select',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestSelector() {
    return AppCard(
      child: Column(
        children: [
          _buildCounterRow(
            label: 'Adults',
            subtitle: 'Ages 13+',
            count: _guests,
            onDecrement: () => _adjustGuests(-1),
            onIncrement: () => _adjustGuests(1),
          ),
          const Divider(),
          _buildCounterRow(
            label: 'Rooms',
            subtitle: 'Number of rooms',
            count: _rooms,
            onDecrement: () => _adjustRooms(-1),
            onIncrement: () => _adjustRooms(1),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterRow({
    required String label,
    required String subtitle,
    required int count,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
              Text(subtitle, style: AppTextStyles.captionSmall),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: count > 1 ? onDecrement : null,
                borderRadius: BorderRadius.circular(AppRadius.circular),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: count > 1 ? AppColors.textPrimary : AppColors.textDisabled,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              SizedBox(
                width: 24,
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              InkWell(
                onTap: onIncrement,
                borderRadius: BorderRadius.circular(AppRadius.circular),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                  child: const Icon(Icons.add, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        _buildPaymentOption('card', 'Credit/Debit Card', Icons.credit_card),
        const SizedBox(height: AppSpacing.sm),
        _buildPaymentOption('paypal', 'PayPal', Icons.account_balance),
        const SizedBox(height: AppSpacing.sm),
        _buildPaymentOption('apple', 'Apple Pay', Icons.apple),
      ],
    );
  }

  Widget _buildPaymentOption(String value, String label, IconData icon) {
    final isSelected = _selectedPaymentMethod == value;
    
    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = value),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          color: isSelected ? AppColors.primary.withOpacity(0.05) : AppColors.surface,
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: AppSpacing.md),
            Text(label, style: AppTextStyles.body),
            const Spacer(),
            Radio<String>(
              value: value,
              groupValue: _selectedPaymentMethod,
              onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingSummary() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Booking Summary', style: AppTextStyles.heading3),
          const SizedBox(height: AppSpacing.md),
          _buildSummaryRow('Check-in', 'Dec 15, 2024'),
          const SizedBox(height: AppSpacing.xs),
          _buildSummaryRow('Check-out', 'Dec 18, 2024'),
          const SizedBox(height: AppSpacing.xs),
          _buildSummaryRow('Guests', '$_guests adults'),
          const SizedBox(height: AppSpacing.xs),
          _buildSummaryRow('Rooms', '$_rooms room'),
          const Divider(height: AppSpacing.lg),
          _buildSummaryRow('Subtotal (3 nights)', '\$135.00'),
          const SizedBox(height: AppSpacing.xs),
          _buildSummaryRow('Service Fee', '\$15.00'),
          const Divider(height: AppSpacing.lg),
          _buildSummaryRow('Total', '\$150.00', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)
              : AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.priceLarge
              : AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: AppElevation.lg,
      ),
      child: SafeArea(
        child: AppButton(
          text: 'Confirm Booking',
          onPressed: _isLoading ? null : _handleBooking,
          isLoading: _isLoading,
          width: double.infinity,
        ),
      ),
    );
  }

  Future<void> _handleBooking() async {
    setState(() => _isLoading = true);
    
    try {
      // TODO: Replace with actual booking API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking confirmed!')),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking failed. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
