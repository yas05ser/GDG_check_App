import 'package:flutter/material.dart';

class ParticipantDetails extends StatefulWidget {
  const ParticipantDetails({super.key});

  @override
  State<ParticipantDetails> createState() => _ParticipantDetailsState();
}

class _ParticipantDetailsState extends State<ParticipantDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset("assets/AppBar.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(child: Image.asset("assets/devfest.png")),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            deatils("Name", "Yasser Laroussi"),
            const SizedBox(
              height: 10,
            ),
            deatils("Phone Number", "0541643058"),
            const SizedBox(
              height: 10,
            ),
            deatils("Email", "larouyasser28@gmail.com"),
            const SizedBox(
              height: 10,
            ),
            deatils("Team", "Legend Team"),
            const SizedBox(
              height: 10,
            ),
            deatils("Birthday", "06/01/2003"),
            const SizedBox(
              height: 10,
            ),
            deatils("State", "Batna"),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset("assets/button2.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Image.asset("assets/button1.png"),
            ),
          ],
        ),
      ),
    );
  }

  Container deatils(key, value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$key :",
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(value, style: const TextStyle(fontSize: 20, color: Colors.blue)),
        ],
      ),
    );
  }
}
