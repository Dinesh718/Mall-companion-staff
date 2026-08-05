// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/shared/presentation/widgets/app_info_card.dart';
import '../../../../core/shared/presentation/widgets/app_section_header.dart';

class GalleryCard extends StatelessWidget {
  final List<String> galleryUrls;

  const GalleryCard({
    super.key,
    required this.galleryUrls,
  });

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          const AppSectionHeader(
            title: 'Store Gallery',
            icon: Icon(
              Icons.photo_library_rounded,
              color: AppColors.primary,
              size: 24.0,
            ),
            horizontalPadding: 0.0,
          ),
          const SizedBox(height: 20.0),

          // Top grid
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Col-span-2 row-span-2: Big image on the left
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      galleryUrls.isNotEmpty ? galleryUrls[0] : '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image_rounded, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),

              // Right column: two small square items
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          galleryUrls.length > 1 ? galleryUrls[1] : '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image_rounded, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          galleryUrls.length > 2 ? galleryUrls[2] : '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image_rounded, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Bottom grid: Add Image, Counter, and Alignment spacing
          Row(
            children: [
              // Add Image dashed container
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F1FF).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: AppColors.outlineVariant.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.grey[600],
                          size: 28.0,
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'Add Image',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),

              // Counter Box
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EBFA), // surface-container
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const Center(
                      child: Text(
                        '+12',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.outline,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Alignment dummy space to match flex 2 left columns
              const SizedBox(width: 8.0),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
