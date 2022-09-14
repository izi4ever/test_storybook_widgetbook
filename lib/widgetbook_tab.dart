import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookTab extends StatefulWidget {
  WidgetbookTab({Key? key}) : super(key: key);

  @override
  State<WidgetbookTab> createState() => _WidgetbookTabState();
}

class _WidgetbookTabState extends State<WidgetbookTab> {
  final fruits = <Widget>[Text('Apple'), Text('Banana'), Text('Orange')];
  final List<bool> _selectedFruits = <bool>[true, false, false];

  // onToggle(int index) {
  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookComponent(
              name: 'ToggleButtons',
              useCases: [
                WidgetbookUseCase(
                  name: 'Base ToggleButton',
                  builder: (context) => Center(
                    child: ToggleButtons(
                      children: fruits,
                      isSelected: _selectedFruits,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      // selectedBorderColor: Colors.red[700],
                      selectedColor: Colors.white,
                      fillColor: context.knobs.options(
                        label: 'Selected Color',
                        options: <Option<Color?>>[
                          Option(label: 'Red', value: Colors.red),
                          Option(label: 'Green', value: Colors.green),
                          Option(label: 'Blue', value: Colors.blue),
                        ],
                      ),
                      color: Colors.red[400],
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 80.0,
                      ),
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedFruits.length; i++) {
                            _selectedFruits[i] = i == index;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Button',
              useCases: [
                WidgetbookUseCase(
                  name: 'elevated',
                  builder: (context) => ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      context.knobs
                          .number(
                            label: 'hello',
                          )
                          .toString(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: ThemeData.light(),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
      appInfo: AppInfo(name: 'Example'),
    );
  }
}
