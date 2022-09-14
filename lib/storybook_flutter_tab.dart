import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final _plugins = initializePlugins(
  contentsSidePanel: true,
  knobsSidePanel: true,
  initialDeviceFrameData: DeviceFrameData(
    device: Devices.ios.iPhone13,
  ),
);

class StorybookFlutterTab extends StatefulWidget {
  const StorybookFlutterTab({super.key});

  @override
  State<StorybookFlutterTab> createState() => _StorybookFlutterTabState();
}

class _StorybookFlutterTabState extends State<StorybookFlutterTab> {
  final fruits = <Widget>[Text('Apple'), Text('Banana'), Text('Orange')];
  final List<bool> _selectedFruits = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) => Storybook(
        initialStory: 'Screens/Scaffold',
        plugins: _plugins,
        stories: [
          Story(
            name: 'ToggleButtons',
            builder: (context) => Center(
              child: ToggleButtons(
                children: fruits,
                isSelected: _selectedFruits,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                // selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: context.knobs.options(
                  label: 'Selected Color',
                  initial: Colors.red,
                  options: [
                    Option(label: 'Red', value: Colors.red),
                    Option(label: 'Green', value: Colors.green),
                    Option(label: 'Blue', value: Colors.blue),
                  ],
                ),
                // fillColor: context.knobs.options(
                //   label: 'Selected Color',
                //   options: <Option<Color?>>[
                //     Option(label: 'Red', value: Colors.red),
                //     Option(label: 'Green', value: Colors.green),
                //     Option(label: 'Blue', value: Colors.blue),
                //   ],
                // ),
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
          Story(
            name: 'Screens/Scaffold',
            description: 'Story with scaffold and different knobs.',
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(
                  context.knobs.text(
                    label: 'Title',
                    initial: 'Scaffold',
                    description: 'The title of the app bar.',
                  ),
                ),
                elevation: context.knobs.nullable.slider(
                  label: 'AppBar elevation',
                  initial: 4,
                  min: 0,
                  max: 10,
                  description: 'Elevation of the app bar.',
                ),
                backgroundColor: context.knobs.nullable.options(
                  label: 'AppBar color',
                  initial: Colors.blue,
                  description: 'Background color of the app bar.',
                  options: const [
                    Option(
                      label: 'Blue',
                      value: Colors.blue,
                      description: 'Blue color',
                    ),
                    Option(
                      label: 'Green',
                      value: Colors.green,
                      description: 'Green color',
                    ),
                  ],
                ),
              ),
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    context.knobs.sliderInt(
                      label: 'Items count',
                      initial: 2,
                      min: 1,
                      max: 5,
                      description: 'Number of items in the body container.',
                    ),
                    (_) => const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Hello World!'),
                    ),
                  ),
                ),
              ),
              floatingActionButton: context.knobs.boolean(
                label: 'FAB',
                initial: true,
                description: 'Show FAB button',
              )
                  ? FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.add),
                    )
                  : null,
            ),
          ),
          Story(
            name: 'Screens/Counter',
            description: 'Demo Counter app with about dialog.',
            builder: (context) => CounterPage(
              title: context.knobs.text(label: 'Title', initial: 'Counter'),
              enabled: context.knobs.boolean(label: 'Enabled', initial: true),
            ),
          ),
          Story(
            name: 'Widgets/Text',
            description: 'Simple text widget.',
            builder: (context) => const Center(child: Text('Simple text')),
          ),
          Story(
              name: 'Story/Nested/Multiple/Times/First',
              builder: (context) => const Center(child: Text('First'))),
          Story(
              name: 'Story/Nested/Multiple/Times/Second',
              builder: (context) => const Center(child: Text('Second'))),
          Story(
              name: 'Story/Nested/Multiple/Third',
              builder: (context) => const Center(child: Text('Third'))),
          Story(
              name: 'Story/Nested/Multiple/Fourth',
              builder: (context) => const Center(child: Text('Fourth'))),
          Story(
              name: 'Story without a category',
              builder: (context) => const Center(child: Text('Simple text'))),
        ],
      );
}

class CounterPage extends StatefulWidget {
  const CounterPage({
    Key? key,
    required this.title,
    this.enabled = true,
  }) : super(key: key);

  final String title;
  final bool enabled;

  @override
  CounterPageState createState() => CounterPageState();
}

class CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () => showAboutDialog(
                context: context,
                applicationName: 'Storybook',
                applicationVersion: '0.0.1',
                applicationIcon: const Icon(Icons.book),
                applicationLegalese: 'MIT License',
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: widget.enabled
            ? FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              )
            : null,
      );
}
