import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

final COLOR_PRIMARY = const Color(0xFF646464);
final COLOR_PRIMARY_LIGHT = const Color(0xFFb0b5bf);
final COLOR_ACCENT = const Color(0xFF661d0f0);

final _todos = <TodoListItem>[
  new TodoListItem(
    title: 'Make a new branding',
    description: '#branding #color',
  ),
  new TodoListItem(
    title: 'Website design',
    description: '#web #grid',
  ),
  new TodoListItem(
    title: 'Icons for finance app',
    description: '#icon #app #ios',
  ),
];

final _done = <TodoListItem>[];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new DefaultTabController(
          length: 3, child: new MyHomePage(title: 'TO-DO')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Widget _buildRow(TodoListItem todo) {
    final alreadyDone = _done.contains(todo);

    return new TodoListRow(
      todo: todo,
      alreadyDone: alreadyDone,
    );
  }

  Widget _buildTodoList(list) {
    return new ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return _buildRow(list[i]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new MainAppBarTitle(widget),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: new PreferredSize(
          preferredSize: new Size(300.0, 60.0),
          child: new Container(
            alignment: Alignment.centerLeft,
            child: new Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: new TabBar(
                labelColor: COLOR_ACCENT,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: COLOR_ACCENT,
                indicatorPadding: new EdgeInsets.all(0.0),
                unselectedLabelColor: COLOR_PRIMARY_LIGHT,
                tabs: <Widget>[
                  new Tab(
                    child: new Text(
                      'LIVE',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Tab(
                    child: new Text(
                      'DONE',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Tab(
                    child: new Text(
                      'ARCHIVE',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildTodoList(_todos),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildTodoList(_done),
          ),
          new Center(child: new Text('ARCHIVE'))
        ],
      ),

      floatingActionButton: new FloatingActionButton(
        backgroundColor: COLOR_ACCENT,
        onPressed: () {
          setState(() {
            _todos.add(new TodoListItem(
              title: 'testing123',
              description: '#testing',
            ));
          });
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TodoListRow extends StatefulWidget {
  const TodoListRow({this.todo, this.alreadyDone});
  final TodoListItem todo;
  final bool alreadyDone;

  @override
  _TodoListRowState createState() {
    return new _TodoListRowState();
  }
}

class _TodoListRowState extends State<TodoListRow> {
  
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Row(
        children: <Widget>[
          new IconButton(
            iconSize: 32.0,
            icon: _done.contains(widget.todo)
                ? new Icon(Icons.check_circle_outline)
                : new Icon(Icons.radio_button_unchecked),
            onPressed: () {
              setState(() {
                if (_done.contains(widget.todo)) {
                  _done.remove(widget.todo);
                } else {
                  _done.add(widget.todo);
                }             
              });
            },
            color: COLOR_PRIMARY_LIGHT,
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: new Text(
                    widget.todo.title,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: COLOR_PRIMARY,
                        fontSize: 16.0),
                  ),
                ),
                new Text(
                  widget.todo.description,
                  style: new TextStyle(color: COLOR_PRIMARY_LIGHT),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TodoListItem {
  const TodoListItem({this.title, this.description});

  final String title;
  final String description;
}

class MainAppBarTitle extends StatelessWidget {
  final MyHomePage widget;

  MainAppBarTitle(this.widget);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: new Text(
        widget.title,
        style: TextStyle(
            color: COLOR_PRIMARY,
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0),
      ),
    );
  }
}
