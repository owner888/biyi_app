import "dart:convert";
import "dart:io";

void main(List<String> args) {
  File icomoonSelectionFile = File('./assets/fonts/icomoon_selection.json');

  if (!icomoonSelectionFile.existsSync()) {
    print('selection file not found');
    exit(0);
  }

  String content = icomoonSelectionFile.readAsStringSync();
  Map<String, dynamic> s = Map<String, dynamic>.from(json.decode(content));
  List<dynamic> icons = List<dynamic>.from(s['icons']);

  List<String> generatedOutput = [
    "import \"package:flutter/widgets.dart\";\n",
    "import \"icon_data.dart\";\n\n",
    "// THIS FILE IS AUTOMATICALLY GENERATED!\n\n",
    "class IcoMoonIcons {\n"
  ];

  for (Map<String, dynamic> icon in List<Map<dynamic, dynamic>>.from(icons)) {
    String iconName = icon['properties']['name'];
    int iconUnicode = icon['properties']['code'];
    generatedOutput.add(
      "    static const IconData ${iconName.replaceAll('-', '_')} = const IcoMoonIconData(0x${iconUnicode.toRadixString(16)});\n",
    );
  }

  generatedOutput.add("}\n");

  File output = File('./lib/widgets/icomoon_icons/icomoon_icons.dart');
  output.writeAsStringSync(generatedOutput.join());
}