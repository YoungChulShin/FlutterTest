import 'package:flutter/material.dart';

class FruitsPage extends StatefulWidget {
  @override
  _FruitsPageState createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                getFoodCard('assets/orange.jpg', 'Orange', '0.75', true),
                getFoodCard('assets/orange.jpg', 'Orange', '0.75', true),
                getFoodCard('assets/orange.jpg', 'Orange', '0.75', true),
                SizedBox(height: 15.0)
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 25.0),
                getFoodCard('assets/orange.jpg', 'Orange', '0.75', true),
                getFoodCard('assets/orange.jpg', 'Orange', '0.75', false),
                getFoodCard('assets/orange.jpg', 'Orange', '0.75', true),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget getFoodCard(String imgPath, String fruitName, String price, bool isFav) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: Container(
        height: 200.0,
        width: (MediaQuery.of(context).size.width) / 2 - 20.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2.0
            )
          ]
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 125.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                    image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: isFav ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.red)
                  ),
                )
              ],
            ), 
            SizedBox(
              height: 15.0
            ),
            Text(
              fruitName, 
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '\$' + price + ' each', 
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
}

