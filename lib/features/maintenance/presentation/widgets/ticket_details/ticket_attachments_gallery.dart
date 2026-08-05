import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../maintenance/domain/entities/ticket_details_entity.dart';

class TicketAttachmentsGallery extends StatelessWidget {
  final List<TicketAttachmentEntity> attachments;

  const TicketAttachmentsGallery({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Photos',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_a_photo_rounded, size: 18.0),
              label: const Text('Add Photo'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 128.0,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: attachments.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16.0),
            itemBuilder: (context, index) {
              final attachment = attachments[index];
              final isImage = attachment.type == 'image';

              return Container(
                width: 192.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppColors.outlineVariant,
                    width: 2.0,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: isImage
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(color: AppColors.surfaceContainer),
                          Image.network(
                            attachment.url,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.image_outlined, color: AppColors.outline),
                              );
                            },
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.insert_drive_file_outlined,
                              color: AppColors.primary,
                              size: 32.0,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              attachment.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
