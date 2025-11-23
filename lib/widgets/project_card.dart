import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> techTags;
  final List<String> screenshots;
  final String? projectUrl;
  final bool isMonetized;
  final bool isRealTime;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.techTags,
    this.screenshots = const [],
    this.projectUrl,
    this.isMonetized = false,
    this.isRealTime = false,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) debugPrint('Could not launch $url');
  }


  void _showGallery() {
    if (widget.screenshots.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        // 1. Local Controllers for the Dialog
        final PageController pageController = PageController();
        int currentIndex = 0;

        // 2. StatefulBuilder allows the Dialog to update its own UI (arrows)
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // CAROUSEL
                  SizedBox(
                    width: double.infinity,
                    height: 600,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: widget.screenshots.length,
                      onPageChanged: (index) {
                        // Update local dialog state
                        setDialogState(() => currentIndex = index);
                      },
                      itemBuilder: (context, index) {
                        return InteractiveViewer(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30), // Make room for arrows
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: _getImageProvider(widget.screenshots[index]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // CLOSE BUTTON (Top Right)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                      style: IconButton.styleFrom(backgroundColor: Colors.black54),
                    ),
                  ),

                  // LEFT ARROW (Previous) - Only show if not first page
                  if (currentIndex > 0)
                    Positioned(
                      left: 0,
                      child: IconButton(
                        onPressed: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black54,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),

                  // RIGHT ARROW (Next) - Only show if not last page
                  if (currentIndex < widget.screenshots.length - 1)
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black54,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else {
      return AssetImage(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasLink = widget.projectUrl != null;
    bool hasScreenshots = widget.screenshots.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.diagonal3Values(1.02, 1.02, 1.02))
            : Matrix4.identity(),
        child: Card(
          elevation: _isHovered ? 8 : 2,
          clipBehavior: Clip.antiAlias,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // IMPORTANT: Removed MainAxisSize.min so Column fills height for Expanded to work
            children: [
              // 1. EXPANDED IMAGE SECTION
              // This takes all available space remaining after Text + Buttons
              Expanded(
                child: Stack(
                  fit: StackFit.expand, // Ensures image fills the Expanded area
                  children: [
                    InkWell(
                      onTap: hasScreenshots ? _showGallery : null,
                      child: hasScreenshots
                          ? Image(
                        image: _getImageProvider(widget.screenshots.first),
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) =>
                            Container(color: Colors.grey[200]),
                      )
                          : Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.image_not_supported,
                            size: 50, color: Colors.grey[400]),
                      ),
                    ),
                    if (hasScreenshots)
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.zoom_in,
                              color: Colors.white, size: 18),
                        ),
                      ),
                  ],
                ),
              ),

              // 2. BODY
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        if (widget.isMonetized)
                          _badge(Icons.monetization_on, Colors.amber),
                        if (widget.isRealTime)
                          _badge(Icons.bolt, Colors.redAccent),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700], height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.techTags
                          .map((tag) => Chip(
                        label: Text(tag,
                            style: const TextStyle(fontSize: 10)),
                        visualDensity: VisualDensity.compact,
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),

              // 3. SMART BUTTONS SECTION
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    if (hasScreenshots && hasLink) ...[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _showGallery,
                          icon: const Icon(Icons.photo_library, size: 18),
                          label: Text(LocaleKeys.buttons_gallery.tr()),
                          style: OutlinedButton.styleFrom(
                              padding:
                              const EdgeInsets.symmetric(vertical: 16)),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      flex: hasLink ? 2 : 1,
                      child: FilledButton.icon(
                        onPressed: hasLink
                            ? () => _launchUrl(widget.projectUrl!)
                            : (hasScreenshots ? _showGallery : null),
                        icon: Icon(
                            hasLink ? Icons.open_in_new : Icons.photo_library,
                            size: 18),
                        label: Text(
                            hasLink ? LocaleKeys.buttons_download_visit.tr() : LocaleKeys.buttons_view_gallery.tr()),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
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

  Widget _badge(IconData icon, Color color) {
    return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(icon, color: color, size: 20));
  }
}