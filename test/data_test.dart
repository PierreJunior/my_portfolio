import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/models/data.dart';

/// Flattens nested translation JSON into dotted keys: `projects.kahvent.title`.
Set<String> _keys(String locale) {
  final json = jsonDecode(File('assets/translations/$locale.json').readAsStringSync());
  final keys = <String>{};
  void walk(Object? node, String prefix) {
    if (node is Map) {
      node.forEach((k, v) => walk(v, prefix.isEmpty ? '$k' : '$prefix.$k'));
    } else {
      keys.add(prefix);
    }
  }

  walk(json, '');
  return keys;
}

void main() {
  final en = _keys('en');
  final fr = _keys('fr');

  test('English and French have the same keys', () {
    expect(en.difference(fr), isEmpty, reason: 'missing in fr.json');
    expect(fr.difference(en), isEmpty, reason: 'missing in en.json');
  });

  test('every key the data model builds exists', () {
    final used = <String>[
      for (final fact in keyFacts) fact.labelKey,
      for (final job in workHistory) ...[job.roleKey, job.durationKey, ...job.achievementKeys],
      for (final group in skillGroups) group.titleKey,
      for (final p in projects) ...[
        p.titleKey,
        p.summaryKey,
        p.key('headline'),
        p.key('period'),
        p.key('role'),
        p.key('platforms'),
        p.key('status'),
        p.key('shot_card'),
        p.key('shot_hero'),
        if (p.featured) p.key('security'),
        ...p.problemKeys,
        for (final f in p.featureKeys) ...[f.title, f.body],
        for (final d in p.decisionKeys) ...[d.title, d.body],
        for (final node in p.architecture) node.detailKey,
      ],
    ];
    expect(used.where((k) => !en.contains(k)), isEmpty);
  });

  test('project slugs are unique and resolvable', () {
    final slugs = projects.map((p) => p.slug).toList();
    expect(slugs.toSet().length, slugs.length);
    for (final slug in slugs) {
      expect(projectBySlug(slug)?.slug, slug);
    }
    expect(projectBySlug('apcms'), isNull);
  });

  test('every referenced screenshot is bundled', () {
    for (final p in projects) {
      for (final path in {...p.screenshots, p.cardImage, p.heroImage}) {
        expect(File(path).existsSync(), isTrue, reason: path);
      }
    }
  });

  test('next case study follows list order and stops at the end', () {
    expect(nextProject('kahvent')?.slug, 'tahadhari');
    expect(nextProject('rosary')?.slug, 'clima');
    expect(nextProject(projects.last.slug), isNull);
    expect(nextProject('apcms'), isNull);
  });

  test('retired projects name their client', () {
    for (final p in projects.where((p) => p.status == ProjectStatus.retired)) {
      expect(p.client, isNotNull, reason: p.slug);
    }
  });
}
