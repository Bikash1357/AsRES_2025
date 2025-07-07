import 'package:event_connect/AttendeeScreens/DaysScreens/Day1.dart';
import 'package:event_connect/AttendeeScreens/DaysScreens/Day2.dart';
import 'package:event_connect/AttendeeScreens/DaysScreens/Day3.dart';
import 'package:flutter/material.dart';

class SpeakersPage extends StatefulWidget {
  @override
  _SpeakersPageState createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AsRES 2025 Conference'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Overview'),
            Tab(text: 'Day 1'),
            Tab(text: 'Day 2'),
            Tab(text: 'Day 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OverviewTab(),
          DayOneTab(),
          DayTwoTab(),
          DayThreeTab(),
        ],
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Added summary text above Conference Summary
          Card(
            elevation: 2,
            color: Colors.blue[50],
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Quick summary of conference for full details please visit Schedule Tab',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildSummaryCard(),
          SizedBox(height: 16),
          _buildDailyBreakdown(),
          SizedBox(height: 16),
          _buildSessionTypes(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Conference Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total Speakers', '290', Colors.blue),
                _buildStatItem('Total Sessions', '52', Colors.green),
                _buildStatItem('Conference Days', '3', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildDailyBreakdown() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Breakdown',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildDayBreakdownItem(
                'Day 1 (July 9, 2025)', '86 speakers', '17 sessions'),
            _buildDayBreakdownItem(
                'Day 2 (July 10, 2025)', '123 speakers', '20 sessions'),
            _buildDayBreakdownItem(
                'Day 3 (July 11, 2025)', '81 speakers', '15 sessions'),
          ],
        ),
      ),
    );
  }

  Widget _buildDayBreakdownItem(String day, String speakers, String sessions) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(day, style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 2,
            child: Text(speakers, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: Text(sessions, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionTypes() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session Types',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSessionTypeChip('Keynote Speeches', Colors.red),
                _buildSessionTypeChip('PhD Colloquiums', Colors.purple),
                _buildSessionTypeChip('Regular Sessions', Colors.blue),
                _buildSessionTypeChip('Panel Discussions', Colors.green),
                _buildSessionTypeChip('Masterclass', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionTypeChip(String label, Color color) {
    return Chip(
      label: Text(label, style: TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}

class DayOneTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Added summary text and navigation button
          Card(
            elevation: 2,
            color: Colors.blue[50],
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Quick summary of conference day 1 for full details please',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Day1july9Screen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Click Here'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildDayHeader('Day 1 - July 9, 2025', '86 speakers', '17 sessions'),
          SizedBox(height: 16),
          _buildSessionCategory('Keynote Speakers', [
            'Jason F. Yong',
            'Professor Jenny George - Welcome',
          ]),
          SizedBox(height: 16),
          _buildSessionCategory('PhD Colloquiums', [
            'PhD Colloquium 1: 4 presenters + 2 discussants',
            'PhD Colloquium 2: 6 presenters + 1 discussant',
            'PhD Colloquium 3: 5 presenters + 2 discussants',
            'PhD Colloquium 4: 5 presenters + 0 discussants',
            'PhD Colloquium 5: 6 presenters + 2 discussants',
          ]),
          SizedBox(height: 16),
          _buildSessionCategory('Regular Sessions', [
            'Financial Markets: 4 presenters + 1 chair',
            'Sustainability (Session 1): 4 presenters + 1 chair',
            'Commercial Real Estate: 4 presenters + 1 chair',
            'Real Estate in Asia: 5 presenters + 1 chair + 2 discussants',
            'Sustainability (Session 2): 5 presenters + 1 chair + 1 discussant',
          ]),
          SizedBox(height: 16),
          _buildSessionCategory('Masterclass', [
            'Professor Naoyuki Yoshino',
            'Peter Verwer',
            'Lin Lee',
            'Dr Raghu Tirumala',
            'Professor Piyush Tiwari',
            'Panel: Professor Desmond Tsang, Professor Quilin Ke, Professor Ashish Gupta, Dr Wayne Wan, Victoria Cook',
          ]),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String day, String speakers, String sessions) {
    return Card(
      elevation: 4,
      color: Colors.blue[50],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(speakers, style: TextStyle(fontWeight: FontWeight.w500)),
                Text(sessions, style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCategory(String title, List<String> sessions) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ...sessions
                .map((session) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 8, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(child: Text(session)),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class DayTwoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Added summary text and navigation button
          Card(
            elevation: 2,
            color: Colors.green[50],
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Quick summary of conference day 2 for full details please',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Day2july10Screen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Click Here'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildDayHeader(
              'Day 2 - July 10, 2025', '123 speakers', '20 sessions'),
          SizedBox(height: 16),
          _buildSessionCategory('Keynote/Welcome Speakers', [
            'Professor Julie Willis',
            'Professor Naoyuki Yoshino (repeat)',
            'Deputy Lord Mayor Roshena Campbell',
            'Peter Verwer (repeat)',
          ]),
          SizedBox(height: 16),
          _buildSessionCategory('Panel Discussion', [
            '1 Moderator + 1 Presenter + 4 Panelists',
          ]),
          SizedBox(height: 16),
          _buildSessionCategory('Regular Sessions', [
            'Transport and Housing: 4 presenters + 1 chair',
            'Data and Technology: 4 presenters + 1 chair',
            'Housing: 5 presenters + 1 chair + 4 discussants',
            'Market Behaviour: 5 presenters + 1 chair + 4 discussants',
            'Policy: 4 presenters + 1 chair + 4 discussants',
            'Planning and Regulation: 5 presenters + 1 chair + 4 discussants',
            'Market Behaviour (2nd): 5 presenters + 1 chair + 4 discussants',
            'Housing (2nd): 5 presenters + 1 chair + 4 discussants',
            'Sustainability (3rd): 4 presenters + 1 chair + 4 discussants',
            'Housing Finance: 5 presenters + 1 chair + 4 discussants',
            'Housing (3rd): 5 presenters + 1 chair + 4 discussants',
            'Affordability: 5 presenters + 1 chair + 4 discussants',
          ]),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String day, String speakers, String sessions) {
    return Card(
      elevation: 4,
      color: Colors.green[50],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(speakers, style: TextStyle(fontWeight: FontWeight.w500)),
                Text(sessions, style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCategory(String title, List<String> sessions) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ...sessions
                .map((session) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 8, color: Colors.green),
                          SizedBox(width: 8),
                          Expanded(child: Text(session)),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class DayThreeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Added summary text and navigation button
          Card(
            elevation: 2,
            color: Colors.orange[50],
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Quick summary of conference day 3 for full details please',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Day3july11Screen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[800],
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Click Here'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildDayHeader(
              'Day 3 - July 11, 2025', '81 speakers', '15 sessions'),
          SizedBox(height: 16),
          _buildSessionCategory('Panel Discussions', [
            'Women in Property Panel: 1 moderator + 4 panelists',
            'MDPI Journals Panel: 1 moderator + 3 panelists',
            'Sustainable Infrastructure Panel: 1 moderator + 4 panelists',
          ]),
          SizedBox(height: 16),
          _buildSessionCategory('Regular Sessions', [
            'Climate Change and ESG: 5 presenters + 1 chair',
            'Climate Change, Carbon Emission: 5 presenters + 1 chair',
            'Urbanization and Land Policies: 5 presenters + 1 chair',
            'Society and Cultural: 5 presenters + 1 chair',
            'Disasters and Relocation: 3 presenters + 1 chair',
            'Agriculture and Farmland: 3 presenters + 1 chair + 1 discussant',
            'Real Estate Markets: 5 presenters + 1 chair',
            'Rental Market: 5 presenters + 1 chair',
            'Housing Institutions and Policy: 5 presenters + 1 chair',
            'House Price: 5 presenters + 1 chair',
            'Sustainability (4th): 3 presenters + 1 chair',
            'House Price and Valuation: 4 presenters + 1 chair',
          ]),
          SizedBox(height: 16),
          _buildSessionCategory('Special Sessions', [
            'PhD Mentoring: 1 coordinator',
          ]),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String day, String speakers, String sessions) {
    return Card(
      elevation: 4,
      color: Colors.orange[50],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(speakers, style: TextStyle(fontWeight: FontWeight.w500)),
                Text(sessions, style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCategory(String title, List<String> sessions) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ...sessions
                .map((session) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 8, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(child: Text(session)),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
