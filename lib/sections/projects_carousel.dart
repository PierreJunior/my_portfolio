import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import '../widgets/project_card.dart'; // Import the card we made earlier
import '../models/data.dart'; // Import your data

class ProjectsCarousel extends StatefulWidget {
  const ProjectsCarousel({super.key});

  @override
  State<ProjectsCarousel> createState() => _ProjectsCarouselState();
}

class _ProjectsCarouselState extends State<ProjectsCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            LocaleKeys.sections_featured_projects.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 20),

        // The Carousel
        SizedBox(
          height: 400, // Fixed height for the card container
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive Logic:
              // Mobile (< 600px): Show 1 card (0.85 fraction)
              // Desktop (> 600px): Show ~3 cards (0.33 fraction)
              double viewportFraction = constraints.maxWidth < 600 ? 0.85 : 0.33;

              _pageController = PageController(
                initialPage: _currentPage,
                viewportFraction: viewportFraction,
              );

              return PageView.builder(
                controller: _pageController,
                itemCount: projects.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final project = projects[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                    child: Center(
                      child: ProjectCard(
                        title: project.title.tr(),
                        description: project.description.tr(),
                        techTags: project.techStack.split(', '),
                        isMonetized: project.title.contains("Rosary"),
                        isRealTime: project.title.contains("Tahadhari"),
                        screenshots: project.screenshots,
                        projectUrl: project.link,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Dots Indicator
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(projects.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}