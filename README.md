# Coverflow

A simple horizontal coverflow widget.
<br><br>


# Preview
![Screen Recording 2021-11-25 at 1 51 14 PM](https://user-images.githubusercontent.com/24351423/143392660-f3c6da06-4518-4ffe-8ab1-caaeef606824.gif)
![Screen Recording 2021-11-25 at 1 28 56 PM](https://user-images.githubusercontent.com/24351423/143392711-d8cf8a13-d71a-4353-ab1c-1510e4e2a333.gif)


# Installation

Add `coverflow: ^2.0.0` to your `pubspec.yaml` dependecies. And import it:

```
import 'package:coverflow/coverflow.dart';
```
<br>

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
<br>

# Params
```
CoverFlow(
    images: images,
    titles: titles,
    displayOnlyCenterTitle: true,
    textStyle: TextStyle(color: Colors.red),
)
```
