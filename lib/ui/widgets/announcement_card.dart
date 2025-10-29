import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback? onTap;
  final String? imageAsset;
  final String? imageUrl;
  final double? imageMaxHeight;
  final bool compact;

  const AnnouncementCard({
    super.key,
    required this.title,
    required this.date,
    this.onTap,
    this.imageAsset,
    this.imageUrl,
    this.imageMaxHeight,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      // Kompakt, kurumsal ve overflow yapmayan düzen: küçük logo + başlık + tarih
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imageAsset != null || imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: (imageAsset != null)
                        ? Image.asset(
                            imageAsset!,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 32,
                                  height: 32,
                                  color: Colors.black12,
                                ),
                          )
                        : Image.network(
                            imageUrl!,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 32,
                                  height: 32,
                                  color: Colors.black12,
                                ),
                          ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              date,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Mevcut görselli dikey düzen (küçültülmüş üst görselle birlikte)
    return Card(
      margin: const EdgeInsets.only(bottom: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageAsset != null || imageUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: imageMaxHeight ?? 132,
                    ),
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: imageAsset != null
                          ? Image.asset(
                              imageAsset!,
                              fit: imageMaxHeight != null
                                  ? BoxFit.contain
                                  : BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.black12),
                            )
                          : Image.network(
                              imageUrl!,
                              fit: imageMaxHeight != null
                                  ? BoxFit.contain
                                  : BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.black12),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
