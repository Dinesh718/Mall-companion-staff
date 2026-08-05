import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';

class MaintenanceSearchBar extends StatefulWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSortTap;
  final String placeholder;

  const MaintenanceSearchBar({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onClearSearch,
    this.onFilterTap,
    this.onSortTap,
    this.placeholder = 'Search ticket, issue or location',
  });

  @override
  State<MaintenanceSearchBar> createState() => _MaintenanceSearchBarState();
}

class _MaintenanceSearchBarState extends State<MaintenanceSearchBar> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(MaintenanceSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != _controller.text && 
        !(widget.searchQuery.isEmpty && _controller.text.isEmpty)) {
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
        widget.onSearchChanged(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        children: [
          // Search Input
          Expanded(
            child: Container(
              height: 48.0,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(99.0),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16.0),
                  const Icon(
                    Icons.search_rounded,
                    color: AppColors.outline,
                    size: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: _onSearchChanged,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        color: AppColors.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        hintStyle: const TextStyle(
                          color: AppColors.outlineVariant,
                          fontSize: 14.0,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                      ),
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _controller.clear();
                        widget.onClearSearch();
                      },
                      child: const Icon(
                        Icons.clear_rounded,
                        color: AppColors.outline,
                        size: 20.0,
                      ),
                    ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
          
          if (widget.onFilterTap != null) ...[
            const SizedBox(width: 12.0),
            // Filter Button
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: const Color(0xFFE5EDFF), // Light blue background
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.filter_list_rounded,
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: widget.onFilterTap,
              ),
            ),
          ],
          
          if (widget.onSortTap != null) ...[
            const SizedBox(width: 12.0),
            // Sort Button
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: const Color(0xFFE5EDFF), // Light blue background
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.sort_rounded,
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: widget.onSortTap,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
