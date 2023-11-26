import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ParticipantDetails extends StatefulWidget {
  const ParticipantDetails(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.email,
      required this.team,
      required this.birthDate,
      required this.state});

  final String name;
  final String phoneNumber;
  final String email;
  final String team;
  final String birthDate;
  final String state;

  @override
  State<ParticipantDetails> createState() => _ParticipantDetailsState();
}

class _ParticipantDetailsState extends State<ParticipantDetails> {
  @override
  Widget build(BuildContext context) {
    DateTime? date = DateTime.tryParse(widget.birthDate);
    String formattedBirthDate = DateFormat("yyyy-MM-dd").format(date!);
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
            deatils("Name", widget.name),
            const SizedBox(
              height: 10,
            ),
            deatils("Phone Number", widget.phoneNumber),
            const SizedBox(
              height: 10,
            ),
            deatils("Email", widget.email),
            const SizedBox(
              height: 10,
            ),
            deatils("Team", widget.team),
            const SizedBox(
              height: 10,
            ),
            deatils("Birthday", formattedBirthDate),
            const SizedBox(
              height: 10,
            ),
            deatils("State", widget.state),
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
            style: const TextStyle(fontSize: 17, color: Colors.black),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(value, style: const TextStyle(fontSize: 17, color: Colors.blue)),
        ],
      ),
    );
  }
}
