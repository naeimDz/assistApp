import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.comments_disabled,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black54,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: const Text(
                  "Over 8+ years of experience and web development and 5+ years of experience in mobile applications development "),
            ),
            _buildTitle("Skills"),
            const SizedBox(height: 10.0),
            _buildSkillRow("Wordpress", 0.75),
            const SizedBox(height: 5.0),
            _buildSkillRow("Laravel", 0.6),
            const SizedBox(height: 5.0),
            _buildSkillRow("React JS", 0.65),
            const SizedBox(height: 5.0),
            _buildSkillRow("Flutter", 0.5),
            const SizedBox(height: 30.0),
            _buildTitle("Experience"),
            _buildExperienceRow(
                company: "Devson",
                position: "Wordpress Developer",
                duration: "2010 - 2012"),
            _buildExperienceRow(
                company: "Arfa Tech",
                position: "Laravel Developer",
                duration: "2012 - 2015"),
            _buildExperienceRow(
                company: "Game Pvt. Ltd.",
                position: "Web Developer",
                duration: "2015 - 2018"),
            _buildExperienceRow(
                company: "Graphic Pvt. Ltd.",
                position: "Flutter Developer",
                duration: "2018 - Current"),
            const SizedBox(height: 20.0),
            _buildTitle("Education"),
            const SizedBox(height: 5.0),
            _buildExperienceRow(
                company: "COMSATA University Islamabad",
                position: "BS Software Engineering",
                duration: "2011 - 2015"),
            _buildExperienceRow(
                company: "Cambridge University, UK",
                position: "A Level",
                duration: "2008 - 2010"),
            _buildExperienceRow(
                company: "Pakistan Board", position: "SLC", duration: "2008"),
            const SizedBox(height: 20.0),
            _buildTitle("Contact"),
            const SizedBox(height: 5.0),
            Row(
              children: const <Widget>[
                SizedBox(width: 30.0),
                Icon(
                  Icons.mail,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "ashkhanhabib38@gmail.com",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: const <Widget>[
                SizedBox(width: 30.0),
                Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "+92 3015031981",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            _buildSocialsRow(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Row _buildSocialsRow() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20.0),
        IconButton(
          color: Colors.indigo,
          icon: const Icon(Icons.facebook),
          onPressed: () {},
        ),
        const SizedBox(width: 5.0),
        IconButton(
          color: Colors.indigo,
          icon: const Icon(Icons.gite_sharp),
          onPressed: () {},
        ),
        const SizedBox(width: 5.0),
        IconButton(
          color: Colors.red,
          icon: const Icon(Icons.youtube_searched_for),
          onPressed: () {},
        ),
        const SizedBox(width: 10.0),
      ],
    );
  }

  ListTile _buildExperienceRow(
      {required String company, String? position, String? duration}) {
    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.only(top: 8.0, left: 20.0),
        child: Icon(
          Icons.circle,
          size: 12.0,
          color: Colors.black54,
        ),
      ),
      title: Text(
        company,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$position ($duration)"),
    );
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 16.0),
        Expanded(
            flex: 2,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level,
          ),
        ),
        const SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20.0),
        SizedBox(
            width: 80.0,
            height: 80.0,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 35.0,
                ))),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Ayesha Habib",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            const Text("Flutter Developer"),
            const SizedBox(height: 5.0),
            Row(
              children: const <Widget>[
                Icon(
                  Icons.map,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Multan, Pakistan",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
