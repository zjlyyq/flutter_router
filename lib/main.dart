import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      // 注册路由
      routes: {
        'second_page':(context) {
          return Center(
            child: Text('SecondPage'),
          );
        },
        'third_page': (context) => ThirdPage()
      },
      // 错误路由处理，统一返回UnknownPage
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return Center(child: Text('404'),);
        });
      },
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String msg = ModalRoute.of(context).settings.arguments as String;
    // TODO: implement build
    return
      Scaffold(
          appBar: AppBar(
            title: Text('大明水果铺', style: TextStyle(color: Color.fromRGBO(146, 32, 46, 1.0)),),
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Text('页面参数：'),
              Text('${msg}')
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pop(context, '大明水果铺');
            },
          ),
        )
    ;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _name = '接受关闭回调参数：';
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: () {
              // 页面参数 + 设置关闭回调
              Navigator.of(context).pushNamed('third_page', arguments: 'Hey!').then((value) {
                setState(() {
                  _name += value;
                });
              });
            }, child: Text('传递页面参数')),
            TextButton(onPressed: () {
              Navigator.pushNamed(context, 'unknown_page');
            }, child: Text('go to unknownPage')),
            TextButton(onPressed: () {
              Navigator.pushNamed(context, 'second_page');
            }, child: Text('go to secondPsge')),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      String msgs = ModalRoute.of(context).settings.arguments;
                      String m1 = msgs.split(",")[0];
                      return Center(
                        child: Column(
                          children: [
                            Text('基本路由也能获取参数: ${m1}'),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('go back'),
                            ),
                          ],
                        )
                      );
                    },
                    settings: RouteSettings(name: 'msg', arguments: '基本路由参数1,基本路由参数2')
                  )
                );
              },
              child: Text('Go to Next Page')
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('$_name')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
