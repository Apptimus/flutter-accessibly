import 'package:accessibly/accessibly.dart';
import 'package:accessibly/widget/accessible_heading_text.dart';
import 'package:accessibly/widget/accessible_text.dart';
import 'package:accessibly/widget/align_widget.dart';
import 'package:accessibly/widget/colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/accessibility_list_item.dart';
import 'widget/font_style_widget.dart';

class AccessiblyScreen extends StatelessWidget {
  const AccessiblyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Accessibly>(
      builder: (context, accessibilitySettings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Accessibly Features',
          themeMode: accessibilitySettings.systemMode
              ? ThemeMode.system
              : (accessibilitySettings.isDark
                  ? ThemeMode.dark
                  : ThemeMode.light),
          darkTheme: accessibilitySettings.darkTheme,
          theme: accessibilitySettings.lightTheme,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Accessibly accessibly = Accessibly();

  @override
  Widget build(BuildContext context) {
    final accessibilitySettings = context.watch<Accessibly>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibly',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AccessiblyHeadingText(
              "Accessibly Modes",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            AccessiblyListItem(
              titleText:
                  accessibilitySettings.isDark ? 'light mode' : 'Dark mode',
              description: 'Enable or disable dark mode',
              value: accessibilitySettings.isDark,
              onChanged: ((accessibilitySettings.monochrome == false) &&
                      accessibilitySettings.systemMode == false)
                  ? (value) => accessibilitySettings.changeTheme()
                  : null,
            ),

            AccessiblyListItem(
              titleText: 'System default mode',
              description: 'Enable or disable system mode',
              value: accessibilitySettings.systemMode,
              onChanged: ((accessibilitySettings.isDark == false) &&
                      (accessibilitySettings.monochrome == false))
                  ? (value) => accessibilitySettings.toggleSystem()
                  : null,
            ),
            AccessiblyListItem(
              titleText: "Monochrome",
              value: accessibilitySettings.monochrome == true,
              onChanged: (value) {
                accessibilitySettings.toggleMonochrome();
                // _updateTheme(context);
              },
            ),

            AccessiblyListItem(
              titleText: "Visually Impaired Mode",
              value: accessibilitySettings.impairedMode,
              onChanged: (value) {
                accessibilitySettings.toggleimpairedMode();
                // _updateTheme(context);
              },
            ),

            AccessiblyListItem(
              titleText: "Cognitive Disability  mode",
              value: accessibilitySettings.cognitiveMode,
              onChanged: (value) {
                accessibilitySettings.togglecognitiveModeMode();
                // _updateTheme(context);
              },
            ),

            // AccessiblyListItem(
            //   titleText: "ADHD  mode",
            //   value: accessibilitySettings.adhd,
            //   onChanged: (value) {
            //     accessibilitySettings.toggleADHDMode();
            //   },
            // ),

            AccessiblyListItem(
              titleText: accessibilitySettings.imageVisibility
                  ? 'Hide Image'
                  : 'Show Image',
              value: !accessibilitySettings.imageVisibility,
              onChanged: (value) {
                accessibilitySettings.hideImage();
                // _updateTheme(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),

            const AccessiblyHeadingText(
              " Readable Experience",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),

            FontStyleWidget(
                increaseFontSize: accessibilitySettings.increaseFontSize,
                decreaseFontSize: accessibilitySettings.decreaseFontSize,
                fontSize: (accessibilitySettings.textScaleFactor),
                title: 'Font Size'),

            FontStyleWidget(
              title: 'Line Height',
              fontSize: accessibilitySettings.lineHeight.toInt(),
              increaseFontSize: accessibilitySettings.increaseLineHeight,
              decreaseFontSize: accessibilitySettings.decreaseLineHeight,
            ),

            FontStyleWidget(
              title: 'Letter Space',
              fontSize: accessibilitySettings.letterSpacing.toInt(),
              increaseFontSize: accessibilitySettings.increaseLetterSpace,
              decreaseFontSize: accessibilitySettings.decreaseLetterSpace,
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AlignWidget(
                    alignment: () {
                      accessibilitySettings.setTextAlignment(TextAlign.left);
                    },
                    icon: Icons.align_horizontal_left,
                    text: "Left Aligned"),
                AlignWidget(
                    alignment: () {
                      accessibilitySettings.setTextAlignment(TextAlign.center);
                    },
                    icon: Icons.align_horizontal_center,
                    text: "Center Aligned"),
                AlignWidget(
                  alignment: () {
                    accessibilitySettings.setTextAlignment(TextAlign.right);
                  },
                  icon: Icons.align_horizontal_right,
                  text: "Right Aligned",
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const AccessiblyHeadingText(
              "Visually Pleasing Experience",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            TextColorPicker(
              key: UniqueKey(),
              title: "Adjust Title Colors",
              onPressed: (Color selectedColor, String text) {
                // Your onPressed callback logic here
                accessibilitySettings.setHeadingColor(selectedColor);
              },
              onColorSelected: (Color color) {},
            ),
            TextColorPicker(
              key: UniqueKey(),
              title: "Adjust Text Colors",
              onPressed: (Color selectedColor, String text) {
                // Your onPressed callback logic here
                accessibilitySettings.setTextColor(selectedColor);
              },
              onColorSelected: (Color color) {},
            ),
            TextColorPicker(
              key: UniqueKey(),
              title: "Adjust Background Colors",
              onPressed: (Color selectedColor, String text) {
                // Your onPressed callback logic here
                accessibilitySettings.setTextBgColor(selectedColor);
              },
              onColorSelected: (Color color) {},
            ),

            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 250.0,
                child: ElevatedButton(
                    onPressed: () {
                      accessibilitySettings.reset();
                    },
                    child: const AccessiblyText("Reset")),
              ),
            )
          ],
        ),
      ),
    );
  }
}





// ListTile(
            //   title: const AccessiblyHeadingText('Font Size',
            //       style: TextStyle(fontSize: 17.0)),
            //   subtitle: const AccessiblyText('Adjust font size',
            //       style: TextStyle(
            //         fontSize: 14.0,
            //       )),
            //   trailing: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       IconButton(
            //         icon: const Icon(Icons.remove),
            //         onPressed: () {
            //           accessibilitySettings.decreaseFontSize();
            //         },
            //       ),
            //       IconButton(
            //         icon: const Icon(Icons.add),
            //         onPressed: () {
            //           accessibilitySettings.increaseFontSize();
            //         },
            //       ),
            //     ],
            //   ),
            // ),

            // ListTile(
            //   title: const AccessiblyHeadingText('Line Height ',
            //       style: TextStyle(fontSize: 17.0)),
            //   subtitle: const AccessiblyText('Adjust line Height',
            //       style: TextStyle(
            //         fontSize: 14.0,
            //       )),
            //   trailing: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       IconButton(
            //         icon: const Icon(Icons.remove),
            //         onPressed: () {
            //           accessibilitySettings.decreaseLineHeight();
            //         },
            //       ),
            //       IconButton(
            //         icon: const Icon(Icons.add),
            //         onPressed: () {
            //           accessibilitySettings.increaseLineHeight();
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // ListTile(
            //   title: const AccessiblyHeadingText('Letter Space ',
            //       style: TextStyle(fontSize: 17.0)),
            //   subtitle: const AccessiblyText(
            //     'Adjust letter Space',
            //     style: TextStyle(
            //       fontSize: 14.0,
            //     ),
            //   ),
            //   trailing: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       IconButton(
            //         icon: const Icon(Icons.remove),
            //         onPressed: () {
            //           accessibilitySettings.decreaseLetterSpace();
            //         },
            //       ),
            //       IconButton(
            //         icon: const Icon(Icons.add),
            //         onPressed: () {
            //           accessibilitySettings.increaseLetterSpace();
            //         },
            //       ),
            //     ],
            //   ),
            // ),
 // const SizedBox(
            //   height: 15,
            // ),
            // ListTile(
            //   title: const AccessiblyHeadingText(' Scalfold BackgroundColor: ',
            //       style: TextStyle(fontSize: 15.0)),
            //   subtitle: const AccessiblyText('Change  BackgroundColor',
            //       style: TextStyle(
            //         fontSize: 14.0,
            //       )),
            //   trailing: SizedBox(
            //     width: 150.0,
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         IconButton(
            //           icon: const Icon(Icons.color_lens, color: Colors.red),
            //           onPressed: () {
            //             accessibilitySettings.setScalfoldColor(Colors.red);
            //           },
            //         ),
            //         IconButton(
            //           icon: const Icon(Icons.color_lens, color: Colors.green),
            //           onPressed: () {
            //             accessibilitySettings.setScalfoldColor(Colors.green);
            //           },
            //         ),
            //         ColorPickerIconButton(
            //           key: UniqueKey(),
            //           title: "background",
            //           onPressed: (Color selectedColor, String background) {
            //             // Your onPressed callback logic here
            //             accessibilitySettings.setScalfoldColor(selectedColor);
            //           },
            //         )
            //       ],
            //     ),
            //   ),
            // ),
