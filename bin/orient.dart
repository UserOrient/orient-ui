// bin/orient.dart
import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: orient add <component>');
    return;
  }

  final command = args[0];
  if (command == 'add' && args.length > 1) {
    final component = args[1];
    addComponent(component);
  }
}

void addComponent(String name) {
  // For now, just fake it
  if (name == 'button') {
    final content = '''
''';

    final file = File('lib/components/ui/button.dart');
    file.createSync(recursive: true);
    file.writeAsStringSync(content);

    print('✓ Created lib/components/ui/button.dart');
  } else {
    print('❌ Component "$name" not found');
  }
}
