import 'package:flighttickets/CustomShapeClipper.dart';
import 'package:flighttickets/SliverTest.dart';
import 'package:flighttickets/flight_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flighttickets/CustomAppBar.dart';

void main() => runApp(MaterialApp(
  title: 'Flight List Mock Up',
  debugShowCheckedModeBanner: false,
  home: HomeScreen(),
  theme: appTheme,
));

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  fontFamily: 'Oxygen'
);

List<String> locations = ['Boston (BOS)', 'New York City (JFK)'];

const TextStyle dropDownLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16.0);
final _searchFieldController = TextEditingController(text: locations[1]);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeScreenTopPart(),
            homeScreenBottomPart,
            homeScreenBottomPart
          ],
        ),
      )
    );
  }
}

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {

  var selectedLocationIndex = 0;
  var isFlightSelected = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400.0, 
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor])
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.white,),
                      SizedBox(width: 16.0),
                      PopupMenuButton(
                        onSelected: (index) {
                          setState(() {
                            selectedLocationIndex = index;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(locations[selectedLocationIndex], style: dropDownLabelStyle),
                            Icon(Icons.keyboard_arrow_down, color: Colors.white)
                          ],
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                          PopupMenuItem(
                            child: Text(locations[0], style: dropDownMenuItemStyle),
                            value: 0
                          ),
                          PopupMenuItem(
                            child: Text(locations[1], style: dropDownMenuItemStyle),
                            value: 1
                          )
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.settings, color: Colors.white)
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                Text('Where would\nyou want to go?', 
                  style: TextStyle(fontSize: 24.0, color: Colors.white), 
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextField(
                      controller: _searchFieldController,
                      style: dropDownMenuItemStyle,
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                        suffix: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: InkWell(
                            child: Icon(Icons.search, color: Colors.black),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)
                                    => InheritedFlightListing(
                                        fromLocation: locations[selectedLocationIndex],
                                        toLocation:_searchFieldController.text,
                                        child: FlightListingScreen(),
                                    )
                                  )
                              );
                            },
                          ),
                        ),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: ChoiceChip(Icons.flight_takeoff, "Flights", isFlightSelected),
                      onTap: () {
                        setState(() {
                          isFlightSelected = true;
                        });
                      },
                    ),
                    SizedBox(width: 20.0),
                    InkWell(
                      child: ChoiceChip(Icons.hotel, "Hotels", !isFlightSelected),
                      onTap: () {
                        setState(() {
                          isFlightSelected = false;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          )
        )
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {

  final IconData icon;
  final String text;
  final bool isSelected;

  ChoiceChip(this.icon, this.text, this.isSelected);

  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.isSelected ?
        BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0)
          )
        ) : null,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              widget.icon,
              size: 20.0,
              color: Colors.white,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0)
            )
          ],
      ),
    );
  }
}

var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);

var homeScreenBottomPart = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Currently Watched Items', style: dropDownMenuItemStyle),
          Spacer(),
          Text('VIEW ALL(12)', style: viewAllStyle),
        ],
      ),
    ),
    Container(
      height: 250.0,
      child: ListView (
        scrollDirection: Axis.horizontal,
        children: cityCards
      ),
    )
  ],
);

List<CityCard> cityCards = [
  CityCard("assets/images/lasvegas.jpg", "Las Vegas", "Feb 2019", "45", "4299", "2250"),
  CityCard("assets/images/athens.jpg", "Sydney", "Dec 2018", "40", "5999", "2399"),
  CityCard("assets/images/athens.jpg", "Athens", "Apr 2019", "50", "9999", "4159"),

];

class CityCard extends StatelessWidget {

  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;

  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount, this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 210.0,
                  width: 160.0,
                  child: Image.asset(imagePath, fit: BoxFit.cover)
                ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  width: 160.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.black12
                        ]
                      )
                    ),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(cityName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0)),
                          Text(monthYear, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 14.0))
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)
                          )
                        ),
                        child: Text("$discount%", style: TextStyle(fontSize: 14.0, color: Colors.black)))

                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 5.0,),
              Text(newPrice, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(width: 5.0,),
              Text(oldPrice, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal)),
            ],
          )
        ],
      ),
    );
  }
}
