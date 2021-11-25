# Coverflow

A simple horizontal coverflow widget.
<br><br>


# Preview


# Installation

Add `coverflow: ^0.0.1` to your `pubspec.yaml` dependecies. And import it:

```
import 'package:coverflow/coverflow.dart';
```

# How to use
Simply add a Coverflow widget with required params.

```
final List<String> titles = [
    "Title1",
    "Title2",
    "Title3",
    "Title4",
    "Title5",
    "Title6",
    "Title7",
    "Title8",
  ];

  final List<Widget> images = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.black,
    ),
    Container(
      color: Colors.cyan,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.grey,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.amber,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: CoverFlow(
            images: images,
            titles: titles,
            textStyle: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
```
