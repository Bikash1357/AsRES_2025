import 'package:event_connect/AdminScreen/AdminEventPage.dart';
import 'package:event_connect/AdminScreen/Admin_AttendeeList.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventConnectAdminPage extends StatefulWidget {
  const EventConnectAdminPage({super.key});

  @override
  _EventConnectAdminPageState createState() => _EventConnectAdminPageState();
}

class _EventConnectAdminPageState extends State<EventConnectAdminPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _updateController = TextEditingController();

  int totalLoggedInUsers = 0;
  bool isLoadingUserCount = true;
  List<Map<String, dynamic>> recentUpdates = [];
  bool isLoadingUpdates = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
    fetchLoggedInUserCount();
    fetchRecentUpdates();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  Future<void> fetchLoggedInUserCount() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      setState(() {
        totalLoggedInUsers = snapshot.docs.length;
        isLoadingUserCount = false;
      });
    } catch (e) {
      print('Error fetching user count: $e');
      setState(() {
        isLoadingUserCount = false;
      });
    }
  }

  Future<void> fetchRecentUpdates() async {
    try {
      setState(() {
        isLoadingUpdates = true;
      });

      QuerySnapshot snapshot = await _firestore
          .collection('Admin')
          .doc('recent_updates')
          .collection('updates')
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> updates = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add document ID for deletion
        updates.add(data);
      }

      setState(() {
        recentUpdates = updates;
        isLoadingUpdates = false;
      });
    } catch (e) {
      print('Error fetching updates: $e');
      setState(() {
        isLoadingUpdates = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _updateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'AsRES 2025',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.grey[600]),
      ),
      body: Column(
        children: [
          // Tab Bar with enhanced styling
          // Replace your existing TabBar in the build method with this:

          // Replace your existing TabBar in the build method with this:

          // Replace your existing TabBar in the build method with this:

          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.blue[600],
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.blue[600],
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              // Remove default padding to prevent extra space
              labelPadding: EdgeInsets.zero,
              // Add this to control tab alignment
              tabAlignment: TabAlignment.start,
              tabs: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dashboard_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Overview'),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people_outline, size: 18),
                      SizedBox(width: 8),
                      Text('Attendees'),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Events'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Content with Animation
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Overview Tab
                  _buildOverviewContent(),
                  // Attendees Tab
                  _buildAttendeesContent(),
                  // Events Tab
                  _buildEventsContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome back! Here.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          _buildAnimatedStatsGrid(),
          const SizedBox(height: 32),
          _buildUpdateSection(),
          const SizedBox(height: 24),
          _buildRecentUpdatesSection(),
        ],
      ),
    );
  }

  Widget _buildAnimatedStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAnimatedStatsCard(
                icon: Icons.people_outline,
                iconColor: Colors.blue[600]!,
                title: 'Total Registered',
                value: '150',
                delay: 0,
                onTap: null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnimatedStatsCard(
                icon: Icons.check_circle_outline,
                iconColor: Colors.green[600]!,
                title: 'Total logged in',
                value:
                    isLoadingUserCount ? '...' : totalLoggedInUsers.toString(),
                delay: 100,
                onTap: null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildAnimatedStatsCard(
                icon: Icons.event_outlined,
                iconColor: Colors.purple[600]!,
                title: 'Total Sessions',
                value: '37',
                delay: 200,
                onTap: () => _showSessionsPopup(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnimatedStatsCard(
                icon: Icons.person_outline,
                iconColor: Colors.orange[600]!,
                title: 'Total Speakers',
                value: '8',
                delay: 300,
                onTap: () => _showSpeakersPopup(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedStatsCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required int delay,
    VoidCallback? onTap,
  }) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutBack,
      builder: (context, double animation, child) {
        return Transform.scale(
          scale: animation,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: onTap != null
                    ? Border.all(color: Colors.blue.withOpacity(0.2))
                    : null,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (onTap != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Tap for details',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUpdateSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.announcement_outlined,
                  color: Colors.blue[600], size: 24),
              const SizedBox(width: 8),
              const Text(
                'Add Any Update',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _updateController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Enter your update here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue[600]!),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _saveUpdate,
              icon: const Icon(Icons.send, size: 18),
              label: const Text('Post Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSpeakersPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Row(
              children: [
                Icon(Icons.person_outline, color: Colors.orange[600]),
                const SizedBox(width: 8),
                const Text('Conference Speakers'),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSpeakerCard(
                    'Jenny George',
                    'Dean Melbourne Business School',
                    'Welcome Address',
                  ),
                  const SizedBox(height: 12),
                  _buildSpeakerCard(
                    'Jason F. Yong',
                    'Chief Investment Officer, CapitalxWise',
                    'Keynote: Accelerating Real Estate Capital & Dealmaking in an AI Era',
                  ),
                  const SizedBox(height: 12),
                  _buildSpeakerCard(
                    'Julie Willis',
                    'Dean ABP',
                    'Day Two Welcome',
                  ),
                  const SizedBox(height: 12),
                  _buildSpeakerCard(
                    'Naoyuki Yoshino',
                    'Advisor FSA Japan',
                    'Keynote Speech',
                  ),
                  const SizedBox(height: 12),
                  _buildSpeakerCard(
                    'Peter Verwer',
                    'Industry Expert',
                    'Keynote: REITs 4.0 - New Frontiers of Global Securitisation',
                  ),
                  const SizedBox(height: 12),
                  _buildSpeakerCard(
                    'Chritina Jiang',
                    'Director at Wealth PI',
                    'Keynote: Panal moderator for "Emerging trends in property finance and investment"',
                  ),
                  const SizedBox(height: 12),
                  _buildSpeakerCard(
                    'Jua Cilliers',
                    'Academic at University of Technology Sydney (UTS)',
                    'Keynote: Panal moderator for "Sustainable infrastructure" discussion',
                  ),
                  const SizedBox(height: 12),
                  _buildSpeakerCard(
                    'Peter Holland',
                    'Industry Expert at real Estate Development',
                    'Keynote: Pana moderator for "Docklands regeneration" discussion',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpeakerCard(String name, String title, String topic) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            topic,
            style: const TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  void _showSessionsPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.event_outlined, color: Colors.purple[600]),
              const SizedBox(width: 8),
              const Text('Conference Sessions'),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDayHeader('Day 1 - 9th July 2025'),
                  _buildSessionItem(
                      'PhD Colloquium Sessions', '7 Sessions', '15 Papers'),
                  _buildSessionItem(
                      'Master Class Sessions', '2 Sessions', 'Net Zero Cities'),
                  const SizedBox(height: 16),
                  _buildDayHeader('Day 2 - 10th July 2025'),
                  _buildSessionItem(
                      'Parallel Sessions (Morning)', '5 Sessions', '25 Papers'),
                  _buildSessionItem('Parallel Sessions (Afternoon)',
                      '5 Sessions', '25 Papers'),
                  const SizedBox(height: 16),
                  _buildDayHeader('Day 3 - 11th July 2025'),
                  _buildSessionItem(
                      'Morning Parallel Sessions', '5 Sessions', '25 Papers'),
                  _buildSessionItem('Sustainable Infrastructure Panel',
                      '4 Sessions', '20 Papers'),
                  _buildSessionItem('Docklands Regeneration Panel',
                      '4 Sessions', '20 Papers'),
                  _buildSessionItem(
                      'Afternoon Parallel Sessions', '5 Sessions', '25 Papers'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Total Summary',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('37 Total Sessions'),
                        Text('188 Total Papers'),
                        Text(
                            '15 PhD Papers + 45 Peer-reviewed + 128 Non-peer-reviewed'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDayHeader(String day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        day,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.purple[600],
        ),
      ),
    );
  }

  Widget _buildSessionItem(String title, String sessions, String details) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                sessions,
                style: TextStyle(
                  color: Colors.purple[600],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '• $details',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveUpdate() async {
    if (_updateController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an update'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Save to subcollection for multiple updates
      await _firestore
          .collection('Admin')
          .doc('recent_updates')
          .collection('updates')
          .add({
        'update': _updateController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'updatedBy': 'Admin', // You can replace with actual admin ID
      });

      _updateController.clear();

      // Refresh the updates list
      fetchRecentUpdates();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Update posted successfully!'),
          backgroundColor: Colors.green[600],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error posting update: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteUpdate(String updateId) async {
    try {
      await _firestore
          .collection('Admin')
          .doc('recent_updates')
          .collection('updates')
          .doc(updateId)
          .delete();

      // Refresh the updates list
      fetchRecentUpdates();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Update deleted successfully!'),
          backgroundColor: Colors.green[600],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting update: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildRecentUpdatesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.history, color: Colors.blue[600], size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'Recent Updates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: fetchRecentUpdates,
                icon: Icon(Icons.refresh, color: Colors.blue[600]),
                tooltip: 'Refresh updates',
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isLoadingUpdates)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            )
          else if (recentUpdates.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No updates yet',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentUpdates.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final update = recentUpdates[index];
                return _buildUpdateCard(update);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildUpdateCard(Map<String, dynamic> update) {
    final timestamp = update['timestamp'] as Timestamp?;
    final dateTime = timestamp?.toDate();
    final formattedDate = dateTime != null
        ? '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}'
        : 'Unknown date';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      update['update'] ?? 'No content',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.person,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          update['updatedBy'] ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _showDeleteConfirmation(update['id']),
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red[400],
                  size: 20,
                ),
                tooltip: 'Delete update',
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                padding: const EdgeInsets.all(4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(String updateId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Update'),
          content: const Text(
              'Are you sure you want to delete this update? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteUpdate(updateId);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAttendeesContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attendees ',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Attendee who are SignUp.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const AttendeeListPage(), // Your existing page content
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create Event ',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Want to create a new event addition to Schedule.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const EventAdminPage(), // Your existing page content
            ),
          ),
        ],
      ),
    );
  }
}
