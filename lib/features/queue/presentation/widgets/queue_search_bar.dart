// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/queue_filter.dart';
import '../bloc/queue_bloc.dart';
import '../bloc/queue_event.dart';

class QueueSearchBar extends StatefulWidget {
  final QueueFilter activeFilter;
  final String searchQuery;

  const QueueSearchBar({
    super.key,
    required this.activeFilter,
    required this.searchQuery,
  });

  @override
  State<QueueSearchBar> createState() => _QueueSearchBarState();
}

class _QueueSearchBarState extends State<QueueSearchBar> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(covariant QueueSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery &&
        widget.searchQuery != _controller.text) {
      _controller.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        context.read<QueueBloc>().add(SearchQueryChanged(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filters = QueueFilter.values;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search Field + clear filters button icon
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
                          onChanged: _onSearchChanged,
                          decoration: const InputDecoration(
                            hintText: 'Search customer, token or phone...',
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
                      if (_controller.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 20.0),
                          onPressed: () {
                            _controller.clear();
                            context.read<QueueBloc>().add(const SearchQueryChanged(''));
                          },
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
                    _controller.clear();
                    context.read<QueueBloc>().add(const ClearFilters());
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
                              colors: AppColors.primaryGradient,
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
                                context.read<QueueBloc>().add(FilterChanged(f));
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
