// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/offer_status.dart';
import '../bloc/offers_bloc.dart';
import '../bloc/offers_event.dart';

class OffersSearchBar extends StatefulWidget {
  final OfferStatus activeFilter;
  final String searchQuery;

  const OffersSearchBar({
    super.key,
    required this.activeFilter,
    required this.searchQuery,
  });

  @override
  State<OffersSearchBar> createState() => _OffersSearchBarState();
}

class _OffersSearchBarState extends State<OffersSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(covariant OffersSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery &&
        widget.searchQuery != _controller.text) {
      _controller.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filters = OfferStatus.values;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search Field + filter button icon
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3FF), // surface-container-low
                    borderRadius: BorderRadius.circular(99.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: (val) {
                            context.read<OffersBloc>().add(SearchOffers(val));
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search by offer title or brand...',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.onSurfaceVariant,
                              fontSize: 14.0,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Container(
                width: 56.0,
                height: 56.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFDEE8FF), // surface-container-high
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.filter_list_off_rounded,
                    color: AppColors.onSurfaceVariant,
                  ),
                  tooltip: 'Clear Filters & Search',
                  onPressed: () {
                    context.read<OffersBloc>().add(const ClearFilters());
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Horizontal scrollable filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: filters.map((f) {
                final isSelected = widget.activeFilter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: isSelected
                      ? Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primaryGradientStart,
                                AppColors.primaryGradientEnd,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(99.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryGradientStart.withOpacity(0.3),
                                blurRadius: 10.0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(99.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 6.0),
                                    Text(
                                      f.toDisplayString(),
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(99.0),
                            border: Border.all(
                              color: AppColors.outlineVariant.withOpacity(0.5),
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                context.read<OffersBloc>().add(FilterOffers(f.name));
                              },
                              borderRadius: BorderRadius.circular(99.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  f.toDisplayString(),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
