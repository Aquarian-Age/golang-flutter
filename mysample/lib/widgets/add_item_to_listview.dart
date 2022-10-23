import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExampleAddItemToListView extends StatefulWidget {
  const ExampleAddItemToListView({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<ExampleAddItemToListView> {
  final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];

  TextEditingController nameController = TextEditingController();

  void addItemToList() {
    setState(() {
      names.insert(0, nameController.text);
      msgCount.insert(0, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tutorial - googleflutter.com'),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleListView3()));
            },
            child: const Text("example-3"),
          ),
          const Divider(),

          ///
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExWidget(),
                ),
              );
            },
            child: const Text('ListView-2'),
          ),
          const Divider(),

          ///----------
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contact Name',
              ),
            ),
          ),
          OutlinedButton(
            child: const Text('Add'),
            onPressed: () {
              addItemToList();
            },
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.all(2),
                    color: msgCount[index] >= 10
                        ? Colors.blue[400]
                        : msgCount[index] > 3
                            ? Colors.blue[100]
                            : Colors.grey,
                    child: Center(
                        child: Text(
                      '${names[index]} (${msgCount[index]})',
                      style: const TextStyle(fontSize: 18),
                    )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

///
class ExWidget extends StatelessWidget {
  const ExWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widget = List.generate(
      20,
      (index) => Container(
        child: Text('My title is $index'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expand"),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: _widget
              .map((e) => ExpansionPanelRadio(
                  value: e,
                  headerBuilder: (BuildContext context, bool isExpanded) => const ListTile(
                        title: Text("My title"),
                      ),
                  body: e))
              .toList(),
        ),
      ),
    );
  }
}

///-------
class ExampleListView3 extends StatefulWidget {
  const ExampleListView3({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExampleListView3State createState() => _ExampleListView3State();
}

class _ExampleListView3State extends State<ExampleListView3> {
  List widgetText = [
    'Container',
    'Text',
    'Column',
    'Row',
    'Replace',
    'Delete',
  ];
  List<Widget> adds = [];
  final ScrollController _scrollController = ScrollController();

  scrollToBottom() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget rowWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        styleText("I'm"),
        styleText("Row"),
        styleText("Widget"),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Widget List",
          style: TextStyle(color: Colors.grey.shade50),
        ),
        backgroundColor: Colors.indigo.shade600,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              if (adds.isNotEmpty) {
                adds.clear();
                setState(() {});
              }
            },
            child: Text(
              "Clear",
              style: TextStyle(color: Colors.grey.shade50),
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 85,
            child: RawScrollbar(
              thickness: 4,
              thumbColor: Colors.indigo,
              radius: const Radius.circular(15),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: adds,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Chip(
                      backgroundColor: Colors.grey.shade100,
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      label: Text(
                        widgetText[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo.shade600,
                        ),
                      ),
                      elevation: 1,
                      side: BorderSide(color: Colors.indigo.shade600),
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          adds.add(containerWidget);
                          scrollToBottom();
                          setState(() {});
                          break;
                        case 1:
                          adds.add(textWidget);
                          scrollToBottom();
                          setState(() {});
                          break;
                        case 2:
                          adds.add(columnWidget);
                          scrollToBottom();
                          setState(() {});
                          break;
                        case 3:
                          adds.add(rowWidget);
                          scrollToBottom();
                          setState(() {});
                          break;
                        case 4:
                          if (adds.length > 0) {
                            adds[0] = rowWidget;
                            scrollToBottom();
                            setState(() {});
                          }
                          break;
                        case 5:
                          if (adds.length > 0) {
                            adds.removeAt(0);
                            scrollToBottom();
                            setState(() {});
                          }
                          break;
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10);
                },
                itemCount: widgetText.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget containerWidget = Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Container(
      height: 30,
      width: double.infinity,
      color: Colors.indigoAccent,
    ),
  );

  Widget textWidget = Padding(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: Text(
      "I'm Text Widget",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.indigo.shade600,
      ),
    ),
  );

  Widget columnWidget = Padding(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: Column(
      children: [
        Text(
          "I'm",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade600,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Column",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade600,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Widget",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade600,
          ),
        ),
      ],
    ),
  );

  Widget styleText(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.indigo.shade600,
      ),
    );
  }
}
