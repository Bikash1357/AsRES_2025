import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Conference Schedule'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4285F4),
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: const Color(0xFF4285F4),
          tabs: const [
            Tab(text: 'Day 1\nJuly 9'),
            Tab(text: 'Day 2\nJuly 10'),
            Tab(text: 'Day 3\nJuly 11'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDayOne(),
          _buildDayTwo(),
          _buildDayThree(),
        ],
      ),
    );
  }

  Widget _buildDayOne() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDayHeader(
              'Day One – 9th July 2025', 'Melbourne Business School'),
          const SizedBox(height: 16),
          _buildScheduleItem('8:30 – 9:50', 'Registration', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem('8:50 – 9:00', 'Welcome',
              'Jenny George, Dean Melbourne Business School', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '9:00 – 9:45',
              'Keynote Speech',
              'Accelerating Real Estate Capital & Dealmaking in an AI Era',
              'Jason F. Yong, Chief Investment Officer, CapitalxWise'),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '9:45 – 11:15',
              'Parallel Sessions',
              'PhD colloquium (2 sessions)\nMaster class (Net zero cities)',
              ''),
          const SizedBox(height: 12),
          _buildScheduleItem('11:15 – 11:30', 'Coffee Break', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '11:30 – 13:00', 'PhD Colloquium', '2 sessions', ''),
          const SizedBox(height: 12),
          _buildScheduleItem('13:00 – 14:00', 'Lunch', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '14:00 – 15:30',
              'Parallel Sessions',
              'PhD colloquium/Session (2 sessions)\nMaster class (Net zero cities – cont\'d)',
              ''),
          const SizedBox(height: 12),
          _buildScheduleItem('15:30 – 15:45', 'Coffee Break', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '15:45 – 17:15', 'PhD Colloquium/Session', '3 sessions', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '17:00 – 18:15',
              'Visit to MSDx Exhibition',
              'Optional and self-guided',
              'Glyn Davis Building, University of Melbourne'),
          const SizedBox(height: 12),
          _buildScheduleItem('17:15 – 19:00', 'Evening Reception', '',
              'University House, Law Building'),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '19:00 – 21:00', 'AsRES Board Meeting 1', 'By invitation', ''),
        ],
      ),
    );
  }

  Widget _buildDayTwo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDayHeader('Day Two – 10th July 2025', 'Marriott Docklands'),
          const SizedBox(height: 16),
          _buildScheduleItem(
              '9:00 – 9:15', 'Welcome', 'Julie Willis, Dean ABP', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '9:15 – 9:30', 'Keynote Speech', 'Depuy Lord Mayor', ''),
          const SizedBox(height: 12),
          _buildScheduleItem('9:30 – 10:15', 'Keynote Speech',
              'Naoyuki Yoshino, Advisor FSA Japan', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '10:15 – 11:00',
              'Keynote Speech',
              'REITs 4.0: new frontiers of global securitisation in the real asset economy',
              'Peter Verwer'),
          const SizedBox(height: 12),
          _buildScheduleItem('11:00 – 11:30', 'Coffee Break', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '11:30 – 12:30',
              'Panel Discussion',
              'Emerging trends in property finance and investment',
              'Moderator: Christina Jiang, Director Wealth Pi'),
          const SizedBox(height: 12),
          _buildScheduleItem('12:30 – 13:30', 'Lunch', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '13:30 – 15:00', 'Parallel Sessions', '5 sessions', ''),
          const SizedBox(height: 12),
          _buildScheduleItem('15:00 – 15:30', 'Coffee Break', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '15:30 – 17:00', 'Parallel Sessions', '5 sessions', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '18:30 – 20:30', 'Conference Dinner', '', 'Marriott Docklands'),
        ],
      ),
    );
  }

  Widget _buildDayThree() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDayHeader('Day Three – 11th July 2025', 'Marriott Docklands'),
          const SizedBox(height: 16),
          _buildScheduleItem('7:00 – 8:30',
              'AsRES Women in Property Network Breakfast', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '9:00 – 10:30', 'Parallel Sessions', '5 sessions', ''),
          const SizedBox(height: 12),
          _buildScheduleItem('10:30 – 11:00', 'Coffee Break', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '11:00 – 12:30',
              'Parallel Sessions/Panel Discussion',
              'Sustainable infrastructure (4 sessions)',
              'Moderator: Jua Cilliers, UTS'),
          const SizedBox(height: 12),
          _buildScheduleItem('12:30 – 13:30', 'Lunch', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '13:30 – 15:00',
              'Parallel Sessions/Panel Discussion',
              'Docklands regeneration (4 sessions)',
              'Moderator: Peter Holland'),
          const SizedBox(height: 12),
          _buildScheduleItem('15:00 – 15:30', 'Coffee Break', '', ''),
          const SizedBox(height: 12),
          _buildScheduleItem(
              '15:30 – 17:00', 'Parallel Sessions', '5 sessions', ''),
          const SizedBox(height: 12),
          _buildScheduleItem('18:30 – 20:30', 'Gala Dinner', '', 'Cargo Dock'),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String day, String venue) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4285F4), Color(0xFF34A853)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            venue,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(
      String time, String title, String description, String location) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4285F4),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
          if (location.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
