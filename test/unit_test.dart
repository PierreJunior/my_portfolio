import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/models/data.dart';

void main() {
  group('Project Data Model', () {
    test('Project instance should hold its values correctly', () {
      const projectTitle = 'My Awesome App';
      const projectDescription = 'This is the description of the project.';
      const projectLink = 'https://github.com/my-awesome-app';

      final myProject = Project(
        title: projectTitle,
        description: projectDescription,
        link: projectLink,
        techStack: '',
        screenshots: [],
      );

      expect(myProject.title, projectTitle);
      expect(myProject.description, projectDescription);
      expect(myProject.link, projectLink);
    });
  });
}
