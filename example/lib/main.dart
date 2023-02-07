import 'package:coordinate_calculator/coordinate_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'coordinate_calculator Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Coordinate Calculator Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double calculatorResult = 0.0;

  /// 起始 经度
  final TextEditingController _originLong = TextEditingController();

  /// 起始 纬度
  final TextEditingController _originLatitude = TextEditingController();

  /// 目标 经度
  final TextEditingController _destLong = TextEditingController();

  /// 目标 纬度
  final TextEditingController _destLatitude = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 54),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 150),
            const Text('请填写起始目标经纬度后\n点击计算按钮',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 24,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 40),
            Row(
              children: <Widget>[
                Container(
                  child: const Text('起始经度'),
                ),
                const SizedBox(width: 10),
                _buildTextField(
                    controller: _originLong,
                    hintText: '请输入起始地经度',
                    formats: [
                      FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)
                    ]),
              ],
            ),
            Container(
              height: 1,
              color: const Color(0xffEEEEEE),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: const Text('起始纬度'),
                ),
                const SizedBox(width: 10),
                _buildTextField(
                    controller: _originLatitude,
                    hintText: '请输入起始地纬度',
                    formats: [
                      FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)
                    ]),
              ],
            ),
            Container(
              height: 1,
              color: const Color(0xffEEEEEE),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Container(
                  child: const Text('目标经度'),
                ),
                const SizedBox(width: 10),
                _buildTextField(
                    controller: _destLong,
                    hintText: '请输入目的地经度',
                    formats: [
                      FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)
                    ]),
              ],
            ),
            Container(
              height: 1,
              color: const Color(0xffEEEEEE),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: const Text('目标纬度'),
                ),
                const SizedBox(width: 10),
                _buildTextField(
                    controller: _destLatitude,
                    hintText: '请输入目的地纬度',
                    formats: [
                      FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)
                    ]),
              ],
            ),
            Container(
              height: 1,
              color: const Color(0xffEEEEEE),
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                if (_originLong.text.isEmpty ||
                    _originLatitude.text.isEmpty ||
                    _destLatitude.text.isEmpty ||
                    _destLong.text.isEmpty) {
                  return;
                }
                var result = DLCoordinateManager.kilometersDistanceFrom(
                    lat1: double.parse(_originLatitude.text),
                    long1: double.parse(_originLong.text),
                    lat2: double.parse(_destLatitude.text),
                    long2: double.parse(_destLong.text));
                calculatorResult = result;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text('点击计算',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            SizedBox(height: 20),
            Text('起始到目的地的距离为${calculatorResult} km',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 24,
                    fontWeight: FontWeight.w700))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboard,
    List<TextInputFormatter>? formats,

    ///明文
    bool visible = true,
  }) {
    return Flexible(
      child: SizedBox(
        height: 36,
        child: TextField(
          inputFormatters: formats,
          keyboardType: keyboard,
          obscureText: !visible,
          cursorColor: Colors.blue,
          style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 16,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 1),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color(0xff999999),
                fontSize: 12,
                fontWeight: FontWeight.w500),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.transparent)),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
