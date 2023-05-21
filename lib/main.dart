import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Hooks Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

/// [HookWidget] is a [StatelessWidget], but it can work similar to
/// a stateful widget by keeping track of states
class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// [controller] is a [TextEditingController]
    ///
    /// Here, we do not need to create and dispose of the controller
    /// The Hook [useTextEditingController] takes care of that.
    final controller = useTextEditingController();

    /// [text] will listen for changes in [controller] and change
    /// state of app accordingly.
    ///
    /// Anytime the value of [text] is changed, anyone listening to
    /// it will be notified (since it is a [ValueNotifier]).
    final text = useState('');

    /// [useEffect] contains the code that consumes [controller] and
    /// updates the [text] state.
    ///
    /// If no key is given to the useEffect() function, then it will be
    /// called everytime the app is hot reloaded.
    /// Here, [controller] is given as key.
    useEffect(() {
      /// Adds a listener to the controller which updates the value of
      /// [text] when the controller is changed
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Text('You typed ${text.value}'),
        ],
      ),
    );
  }
}
