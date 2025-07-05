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
                value: '32',
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
                value: '212',
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
    // Complete list of all 212 speakers from the conference
    final List<Map<String, String>> allSpeakers = [
      // Keynote Speakers (4)
      {
        'name': 'Jason F. Yong',
        'title': 'Chief Investment Officer, CapitalxWise',
        'category': 'Keynote Speaker'
      },
      {
        'name': 'Professor Naoyuki Yoshino',
        'title':
            'Professor Emeritus of Economics, Keio University, Former Dean, Asian Development Bank Institute',
        'category': 'Keynote Speaker'
      },
      {
        'name': 'Deputy Lord Mayor Roshena Campbell',
        'title': 'City of Melbourne',
        'category': 'Keynote Speaker'
      },
      {
        'name': 'Peter Verwer, AO',
        'title': 'Industry Expert',
        'category': 'Keynote Speaker'
      },

      // Panel Moderators & Chairs (7)
      {
        'name': 'Professor Jenny George',
        'title': 'Dean, Melbourne Business School',
        'category': 'Panel Moderator'
      },
      {
        'name': 'Professor Julie Willis',
        'title':
            'Dean Faculty of Architecture, Building and Planning, University of Melbourne',
        'category': 'Panel Moderator'
      },
      {
        'name': 'Jack Jiang',
        'title': 'Director, Wealth Pi Fund',
        'category': 'Panel Moderator'
      },
      {
        'name': 'Professor Janet Ge',
        'title': 'University of Technology Sydney',
        'category': 'Panel Moderator'
      },
      {
        'name': 'Peter Holland',
        'title': 'Director, Grant Advisory',
        'category': 'Panel Moderator'
      },
      {
        'name': 'Professor Jua Cilliers',
        'title': 'University of Technology Sydney',
        'category': 'Panel Moderator'
      },
      {
        'name': 'Dr Godwin Kavaarpuo',
        'title': 'Academic Researcher',
        'category': 'Panel Moderator'
      },

      // Panel Participants (11)
      {
        'name': 'Christina Jiang',
        'title': 'Director, Wealth Pi Fund',
        'category': 'Panel Participant'
      },
      {
        'name': 'Jeff Davies',
        'title': 'Director, KordaMentha Real Estate',
        'category': 'Panel Participant'
      },
      {
        'name': 'Wendy Fergie',
        'title': 'CIO, Wealth Pi Fund',
        'category': 'Panel Participant'
      },
      {
        'name': 'Ke Lu',
        'title': 'Director, 16MC Development',
        'category': 'Panel Participant'
      },
      {
        'name': 'Professor Robert Edelstein',
        'title': 'University of California',
        'category': 'Panel Participant'
      },
      {
        'name': 'Christian Grahame',
        'title': 'Head of HOME Apartments',
        'category': 'Panel Participant'
      },
      {
        'name': 'Brendon Rogers',
        'title': 'Partner, Urbis',
        'category': 'Panel Participant'
      },
      {
        'name': 'Rob Adams AM',
        'title': 'Director, Adams Urban',
        'category': 'Panel Participant'
      },
      {
        'name': 'Gail Hall',
        'title': 'Australasian Green Infrastructure Network',
        'category': 'Panel Participant'
      },
      {
        'name': 'Luli Castello',
        'title': 'Australasian Green Infrastructure Network',
        'category': 'Panel Participant'
      },
      {
        'name': 'Victoria Cook',
        'title': 'Yarra Valley Water',
        'category': 'Panel Participant'
      },

      // Session Chairs (29)
      {
        'name': 'Kazuto Sumita',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Yang Shi',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Samuel Swanzy-Impraim',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Ming-Chi Chen',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Saurabh Verma',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Tien Foo Sing',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Desmond Tsang',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Hyunmin Kim',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Ashish Gupta',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Timothy Riddiough',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Jyoti Shukla',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Ameeta Jain',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Edward Chi Ho Tang',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Bor-Ming Hsieh',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Raghu Tirumala',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Weida Kuang',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Shotaro Watanabe',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Jae Won Kang',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Fan Zhang',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Zarita Ahmad',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Justine Wang',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Ainoriza Mohd Aini',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Jinyoo Kim',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Yu Feng',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Wayne Wan',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Tyler Yang',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Tsur Somerville',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Shuya Yang',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },
      {
        'name': 'Kang Mo Koo',
        'title': 'Academic Researcher',
        'category': 'Session Chair'
      },

      // Presenters & Authors (136)
      {
        'name': 'Weilong Kong',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jinfang Pu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Kyung-hyun Park',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ayodele Adegoke',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Po-Wei Fu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ge-Ting Yan',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Wen-Jia Su',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Amaraporn Khaikham',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Pornraht Pongprase',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Thomas Chen',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Xiaoqi Liu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ze Wang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Seok Ying Chua',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Tomoki Nishiyama',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Nurulanis Ahmad',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Yasmin Mohd Adnan',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Kohei Tsujii',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Sayoko Hattori',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Naoki Toyoyoshi',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Dengjin Wu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Uyanwaththe Gedara Geethika Nilanthi Kumari',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Shijun Liu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Fang-Ni Chu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ying-Hui Chiang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Chih Yuan Yang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jianping Gu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Yayu Xu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jianing Wang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Liuming Yang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jeongseob Kim',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Benedict Lai',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Sandy Padilla',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Prashant Das',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Pritha Dev',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Farzaneh Janakipour',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Noor Farhana Akrisha Ishak',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Norulelin Huri',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Dongkai Li',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Chiu-Ming Shen',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Fatin Aziz',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jiaxin Zheng',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Rongjie Zhang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jing Wu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Keyang Li',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Yixun Tang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Qiuyi Wang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Masatomo Suzuki',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Norifumi Yukutake',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Soonmahn Park',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Young-Hyuck Kim',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Akshay Bhardawaj',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Xinru Wu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Satapat Kanchong',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Bowen Jiang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Gyojun Shin',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Lin Lee',
        'title': 'Cushman and Wakefield',
        'category': 'Presenter'
      },
      {
        'name': 'Dr Raghu Tirumala',
        'title': 'University of Melbourne',
        'category': 'Presenter'
      },
      {
        'name': 'Professor Piyush Tiwari',
        'title': 'University of Melbourne',
        'category': 'Presenter'
      },
      {'name': 'Professor Quilin Ke', 'title': 'UCL', 'category': 'Presenter'},
      {'name': 'Dr Wayne Wan', 'title': 'Monash', 'category': 'Presenter'},
      {
        'name': 'Yaopei Wang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Zhankun Chen',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Xin Janet Ge',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Pei-Syuan Lin',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Eunhye Beak',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ziyi Bian',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Alaknanda Menon',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Yanhao Ding',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ying Fan',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Daizhong Tang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jingyi Wang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jiayu Zhang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Dongho Kim',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Hiroshi Ishijima',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Rita Yi Man Li',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Dahai Liu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Hainan Sheng',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Boyuan Huang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {'name': 'Lin', 'title': 'Academic Researcher', 'category': 'Presenter'},
      {
        'name': 'Naoya Sato',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Shuai Shi',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Qiang Li',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Weng Wai Choong',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Sheau Ting Low',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jing-Yi Chen',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Nanyu Chu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Mohd Fitry bin Hassim',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'William K S Cheung',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Cheng Tang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ming Shann Tsai',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Shu Ling Chiang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Eric Fesselmeyer',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Chai Duo',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Seonghun Min',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ming-Che Wu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ling Zhang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Yongman WuDuo',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ji-Na Kim',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Yilan Luo',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jianshuang Fan',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Minghang Yu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Hee Jin Yang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Hyung Min Kim',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Zhi Min Zhang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jeongseop Song',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Zheng Zheng',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Naoto Mikawa',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Mieko Fujisawa',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Mizuki Kawabata',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Yi Li',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Graeme Newell',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Samuel Swanzy-Imprain',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Lin Zhou',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Zixiao Chen',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Alyas Widita',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Yiyi Zhao',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Zeshen Ye',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Qilin Huang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Keming Li',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Hui Zeng',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Song Wang',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Zhiwei Liao',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Tzu-Chin Lin',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Manman Xia',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Shaun Bond',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Rongxi Quan',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Hefan Zheng',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Zafirah Al Sadat Zyed',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jia Liu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Qiulin Ke',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Tsubasa Ito',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Ervi Liusman',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Kezia Hsu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Hoon Han',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Jiahao Liu',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },
      {
        'name': 'Beverley Lim',
        'title': 'Academic Researcher',
        'category': 'Presenter'
      },

      // Discussants (25 - Note: Some may have dual roles)
      {
        'name': 'Godwin Kavaarpuo',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Jae Won Kang',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Masatomo Suzuki',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Alaknanda Menon',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Jingyi Wang',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Dongho Kim',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Hainan Sheng',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Boyuan Huang',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Shuya Yang',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Hyung Min Kim',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Minghng Yu',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Hee Jin Yang',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Edward Tang',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Weng Wai Choong',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Jing-Yi Chen',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Nanyu Chu',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Edward Chi Ho Tang',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Ming Shann Tsai',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Seonghun Min',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Chai Duo',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Weida Kuang',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Pei-Syuan Lin',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Ming-Che Wu',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Yilan Luo',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
      {
        'name': 'Shotaro Watanabe',
        'title': 'Academic Researcher',
        'category': 'Discussant'
      },
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.orange[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'AsRES 2025 - All Speakers',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Total: ${allSpeakers.length} speakers',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),

                // Category Filter Pills
                Container(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryPill('All', allSpeakers.length, true),
                        const SizedBox(width: 8),
                        _buildCategoryPill(
                            'Keynote Speaker',
                            allSpeakers
                                .where(
                                    (s) => s['category'] == 'Keynote Speaker')
                                .length,
                            false),
                        const SizedBox(width: 8),
                        _buildCategoryPill(
                            'Panel Moderator',
                            allSpeakers
                                .where(
                                    (s) => s['category'] == 'Panel Moderator')
                                .length,
                            false),
                        const SizedBox(width: 8),
                        _buildCategoryPill(
                            'Session Chair',
                            allSpeakers
                                .where((s) => s['category'] == 'Session Chair')
                                .length,
                            false),
                        const SizedBox(width: 8),
                        _buildCategoryPill(
                            'Presenter',
                            allSpeakers
                                .where((s) => s['category'] == 'Presenter')
                                .length,
                            false),
                      ],
                    ),
                  ),
                ),

                // Speakers List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: allSpeakers.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final speaker = allSpeakers[index];
                      return _buildSpeakerCard(
                        speaker['name']!,
                        speaker['title']!,
                        speaker['category']!,
                      );
                    },
                  ),
                ),

                // Footer
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Conference Dates: July 9-11, 2025',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryPill(String category, int count, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange[600] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.orange[600]! : Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            category,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color:
                  isSelected ? Colors.white.withOpacity(0.2) : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakerCard(String name, String title, String category) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.orange[600],
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(category),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Keynote Speaker':
        return Colors.purple[600]!;
      case 'Panel Moderator':
        return Colors.blue[600]!;
      case 'Panel Participant':
        return Colors.green[600]!;
      case 'Session Chair':
        return Colors.orange[600]!;
      case 'Presenter':
        return Colors.teal[600]!;
      case 'Discussant':
        return Colors.indigo[600]!;
      default:
        return Colors.grey[600]!;
    }
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
                      'Keynote Sessions', '2 Sessions', 'Industry Leaders'),
                  _buildSessionItem(
                      'Parallel Sessions (Morning)', '5 Sessions', '25 Papers'),
                  _buildSessionItem('Parallel Sessions (Afternoon)',
                      '5 Sessions', '25 Papers'),
                  const SizedBox(height: 16),
                  _buildDayHeader('Day 3 - 11th July 2025'),
                  _buildSessionItem(
                      'Keynote Sessions', '2 Sessions', 'Academic Leaders'),
                  _buildSessionItem(
                      'Morning Parallel Sessions', '5 Sessions', '25 Papers'),
                  _buildSessionItem(
                      'Panel Sessions', '3 Sessions', 'Expert Panels'),
                  _buildSessionItem(
                      'Afternoon Parallel Sessions', '1 Session', '5 Papers'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.analytics,
                                color: Colors.blue[600], size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Conference Statistics',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildStatRow('Total Sessions:', '32 sessions'),
                        _buildStatRow('Session Types:',
                            'Keynotes, Panels, Colloquia, Regular'),
                        const SizedBox(height: 8),
                        _buildStatRow('Total Speakers:', '212 unique speakers'),
                        _buildStatRow('Speaker Types:',
                            'Keynote, Moderators, Chairs, Presenters'),
                        const SizedBox(height: 8),
                        _buildStatRow('Total Papers:', '95 papers'),
                        _buildStatRow(
                            'Paper Distribution:', '15 PhD + 80 Peer-reviewed'),
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

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
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
