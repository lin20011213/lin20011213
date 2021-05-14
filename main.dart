import 'package:flutter/material.dart';
import 'QR.dart';
import 'LIstvi.dart';
import 'storge.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BottomNavigationController(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavigationController extends StatefulWidget {
  BottomNavigationController({Key key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  //目前選擇頁索引值
  int _currentIndex = 0; //預設值
  final pages = [scanqr(),listview()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRtraining'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('掃描')),
          //BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('聊天室')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('飲食紀錄')),
        ],
        currentIndex: _currentIndex, //目前選擇頁索引值
        fixedColor: Colors.amber, //選擇頁顏色
        onTap: _onItemClick, //BottomNavigationBar 按下處理事件

      ),

    );

  }

  //BottomNavigationBar 按下處理事件，更新設定當下索引值
  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}