// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'usage.dart';

const String version = '0.7.0';

const String baseUrl =
    'https://raw.githubusercontent.com/userorient/orient-ui/main/templates';

const String aiBaseUrl =
    'https://raw.githubusercontent.com/userorient/orient-ui/main/ai';

final Map<String, ComponentInfo> components = {
  'button': ComponentInfo(
    'button.dart',
    dependencies: ['spinner'],
  ),
  'info_banner': ComponentInfo('info_banner.dart'),
  'card_box': ComponentInfo('card_box.dart'),
  'multi_choice': ComponentInfo('multi_choice.dart'),
  'multi_choice_tile': ComponentInfo(
    'multi_choice_tile.dart',
    dependencies: ['multi_choice', 'tile'],
  ),
  'single_choice': ComponentInfo('single_choice.dart'),
  'single_choice_tile': ComponentInfo(
    'single_choice_tile.dart',
    dependencies: ['single_choice', 'tile'],
  ),
  'confirmation_popup': ComponentInfo(
    'confirmation_popup.dart',
    dependencies: ['button'],
  ),
  'copy_button': ComponentInfo('copy_button.dart'),
  'empty_state': ComponentInfo('empty_state.dart'),
  'nav_bar': ComponentInfo('nav_bar.dart'),
  'spinner': ComponentInfo('spinner.dart'),
  'toast': ComponentInfo('toast.dart'),
  'alert_popup': ComponentInfo('alert_popup.dart'),
  'popup': ComponentInfo('popup.dart'),
  'search_field': ComponentInfo('search_field.dart'),
  'tile': ComponentInfo('tile.dart'),
  'toggle': ComponentInfo('toggle.dart'),
  'toggle_tile': ComponentInfo(
    'toggle_tile.dart',
    dependencies: ['toggle', 'tile'],
  ),
  'picker': ComponentInfo('picker.dart'),
  'popover_menu': ComponentInfo('popover_menu.dart'),
  'tappable_icon': ComponentInfo('tappable_icon.dart'),
  'segment_bar': ComponentInfo('segment_bar.dart'),
  'tabs': ComponentInfo('tabs.dart'),
  'tag': ComponentInfo('tag.dart'),
};

void main(List<String> args) async {
  if (args.isEmpty) {
    _printUsage();
    await _checkForUpdate();
    return;
  }

  final String command = args[0];

  switch (command) {
    case 'init':
      await _initCommand();
      break;
    case 'add':
      if (args.length < 2) {
        _listComponents();
        await _checkForUpdate();
        return;
      }
      await _addCommand(args[1]);
      break;
    default:
      _printUsage();
  }

  await _checkForUpdate();
}

void _log(String emoji, String message) => print('$emoji $message');

void _printUsage() {
  print('Orient UI - Design system for Flutter');
  print('Usage:');
  print('  orient_ui init           Initialize style');
  print('  orient_ui add            List available components');
  print('  orient_ui add <widget>   Add a widget');
}

void _listComponents() {
  _log('📦', 'Available widgets:\n');
  for (final name in components.keys) {
    print('  • $name');
  }
  _log('\n💡', 'Usage: orient_ui add <widget>');
}

Future<void> _initCommand() async {
  _log('🎨', 'Initializing Orient UI...');

  try {
    await _fetchAndSave('style.dart', 'lib/style.dart');
    _log('✅', 'lib/style.dart');
    _log('💡', 'Components follow system brightness by default.');
    _log('  ', 'To control brightness manually, wrap your app:');
    print('   ┌─────────────────────────────────');
    print('   │ Style(');
    print('   │   brightness: Brightness.light,');
    print('   │   child: MaterialApp(...)');
    print('   │ )');
    print('   └─────────────────────────────────');

    await _setupAiRules();

    print('');
    _log('🎉', 'Orient UI is ready. Your AI already knows it.');
  } catch (e) {
    _log('❌', 'Failed: $e');
    exit(1);
  }
}

Future<void> _setupAiRules() async {
  final String rules = await _fetchContent('$aiBaseUrl/rules.md');
  final String cursorFrontmatter = await _fetchContent(
    '$aiBaseUrl/cursor.yaml',
  );

  // CLAUDE.md
  _writeRules('CLAUDE.md', rules);

  // AGENTS.md (OpenAI Codex)
  _writeRules('AGENTS.md', rules);

  // .windsurfrules
  _writeRules('.windsurfrules', rules);

  // .cursor/rules/orient-ui.mdc (always own file, no append)
  final File cursorFile = File('.cursor/rules/orient-ui.mdc');
  cursorFile.createSync(recursive: true);
  cursorFile.writeAsStringSync('$cursorFrontmatter$rules');
  _log('✅', '.cursor/rules/orient-ui.mdc');
}

void _writeRules(String path, String rules) {
  final File file = File(path);

  if (file.existsSync()) {
    // Bump headings: # -> ##, ## -> ###, etc.
    final String bumped = rules.replaceAllMapped(
      RegExp(r'^(#+)', multiLine: true),
      (m) => '${m[1]}#',
    );
    file.writeAsStringSync('\n$bumped', mode: FileMode.append);
  } else {
    file.writeAsStringSync(rules);
  }

  _log('✅', path);
}

Future<String> _fetchContent(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch $url (${response.statusCode})');
  }
  return response.body;
}

Future<void> _addCommand(String widget) async {
  if (!components.containsKey(widget)) {
    _log('❌', 'Widget "$widget" not found');
    _listComponents();
    exit(1);
  }

  final ComponentInfo component = components[widget]!;

  try {
    await _fetchAndSave(component.filename, 'lib/$widget.dart');
    _log('✅', 'Created lib/$widget.dart');
    _log('💡', 'Update the style.dart import path in $widget.dart');

    if (component.dependencies.isNotEmpty) {
      _log(
        '⚠️ ',
        'Depends on: ${component.dependencies.join(', ')} → orient_ui add ${component.dependencies.first}',
      );
    }

    _printUsageBox(widget);
  } catch (e) {
    _log('❌', 'Failed: $e');
    exit(1);
  }
}

// ANSI colors
const _green = '\x1B[32m';
const _blue = '\x1B[34m';
const _yellow = '\x1B[33m';
const _magenta = '\x1B[35m';
const _dim = '\x1B[2m';
const _r = '\x1B[0m';

String _highlight(String code) {
  // Single-pass: match strings, comments, keywords, types, numbers in order
  final RegExp pattern = RegExp(
    r"'[^']*'" // strings
    r'|//.*' // comments
    r'|\b(true|false|null)\b' // keywords
    r'|\b(\d+\.?\d*)\b' // numbers
    r'|\b([A-Z]\w+)\b', // types
  );

  return code.replaceAllMapped(pattern, (m) {
    final String match = m[0]!;
    if (match.startsWith("'")) return '$_green$match$_r';
    if (match.startsWith('//')) return '$_dim$match$_r';
    if (match == 'true' || match == 'false' || match == 'null')
      return '$_blue$match$_r';
    if (RegExp(r'^\d').hasMatch(match)) return '$_magenta$match$_r';
    if (RegExp(r'^[A-Z]').hasMatch(match)) return '$_yellow$match$_r';
    return match;
  });
}

void _printUsageBox(String widget) {
  final Usage? usage = usageMap[widget];
  if (usage == null) return;

  print('');
  print('   $_dim┌${'─' * 60}$_r');

  for (int i = 0; i < usage.code.length; i++) {
    if (i > 0) print('   $_dim│$_r');
    for (final line in usage.code[i].split('\n')) {
      print('   $_dim│$_r ${_highlight(line)}');
    }
  }

  if (usage.hints.isNotEmpty) {
    print('   $_dim│$_r');
    for (final hint in usage.hints) {
      print('   $_dim│$_r • $hint');
    }
  }

  print('   $_dim└${'─' * 60}$_r');
}

class ComponentInfo {
  final String filename;
  final List<String> dependencies;

  ComponentInfo(this.filename, {this.dependencies = const []});
}

Future<void> _fetchAndSave(String filename, String destination) async {
  final String url = '$baseUrl/$filename';
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch (${response.statusCode})');
  }

  final File file = File(destination);
  file.createSync(recursive: true);
  file.writeAsStringSync(response.body);
}

Future<void> _checkForUpdate() async {
  try {
    final http.Response response = await http
        .get(Uri.parse('https://pub.dev/api/packages/orient_ui'))
        .timeout(const Duration(seconds: 3));

    if (response.statusCode != 200) return;

    final Map<String, dynamic> data = jsonDecode(response.body);
    final String latest = data['latest']['version'] as String;

    if (latest == version) return;

    const dim = '\x1B[2m';
    const green = '\x1B[32m';
    const bold = '\x1B[1m';
    const reset = '\x1B[0m';

    print('');
    _log(
      '🆕',
      '${bold}New version available!$reset  $dim$version$reset → $green$bold$latest$reset',
    );
    _log('  ', '${dim}Updating...$reset');

    final ProcessResult result = await Process.run(
      'dart',
      ['pub', 'global', 'activate', 'orient_ui'],
    );

    if (result.exitCode == 0) {
      _log('✅', '${green}Updated to $latest!$reset');
    } else {
      _log('⚠️ ', '${dim}Auto-update failed. Run manually:$reset');
      print('   dart pub global activate orient_ui');
    }
  } catch (_) {
    // Silently ignore - don't block CLI usage if check fails
  }
}
