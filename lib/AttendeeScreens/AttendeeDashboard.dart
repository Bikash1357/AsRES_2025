import 'package:event_connect/AdminScreen/AdminDashboard.dart';
import 'package:event_connect/AttendeeScreens/AboutAsRES.dart';
import 'package:event_connect/AttendeeScreens/AttendeeLocation.dart';
import 'package:event_connect/AttendeeScreens/AttendeeSchedule.dart';
import 'package:event_connect/AttendeeScreens/AttendeeSpeakers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/SignIN.dart';
import 'AttendeeRecentUpdate.dart';

class EventConnectDashboard extends StatefulWidget {
  const EventConnectDashboard({super.key});

  @override
  State<EventConnectDashboard> createState() => _EventConnectDashboardState();
}

class _EventConnectDashboardState extends State<EventConnectDashboard>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<String> _tabs = ['Overview', 'Schedule', 'Speaker', 'Location'];
  User? _currentUser;
  bool _isLoading = false;
  int totalNotificationCount =
      0; // Combined count for both recent updates and new events

  // Animation controllers
  late AnimationController _tabSwitchController;
  late AnimationController _contentFadeController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupNotificationListener();
    _getCurrentUser();
    _initializeAnimations();
  }

  void _setupNotificationListener() {
    // Listen to Recent Updates
    Stream<QuerySnapshot> recentUpdatesStream = FirebaseFirestore.instance
        .collection('Admin')
        .doc('recent_updates')
        .collection('updates')
        .snapshots();

    // Listen to New Events
    Stream<DocumentSnapshot> newEventsStream = FirebaseFirestore.instance
        .collection('Admin')
        .doc('created_event')
        .snapshots();

    // Combine both streams to get total count
    recentUpdatesStream.listen((recentUpdatesSnapshot) {
      _updateNotificationCount(recentUpdatesSnapshot, null);
    });

    newEventsStream.listen((newEventsSnapshot) {
      _updateNotificationCount(null, newEventsSnapshot);
    });
  }

  int _recentUpdatesCount = 0;
  int _newEventsCount = 0;

  void _updateNotificationCount(QuerySnapshot? recentUpdatesSnapshot,
      DocumentSnapshot? newEventsSnapshot) {
    setState(() {
      // Update recent updates count
      if (recentUpdatesSnapshot != null) {
        _recentUpdatesCount = recentUpdatesSnapshot.docs.length;
      }

      // Update new events count
      if (newEventsSnapshot != null) {
        if (newEventsSnapshot.exists && newEventsSnapshot.data() != null) {
          Map<String, dynamic> data =
              newEventsSnapshot.data() as Map<String, dynamic>;
          List<dynamic> events = data['events'] ?? [];
          _newEventsCount = events.length;
        } else {
          _newEventsCount = 0;
        }
      }

      // Calculate total notification count
      totalNotificationCount = _recentUpdatesCount + _newEventsCount;
    });
  }

  void _initializeAnimations() {
    // Tab switch animation
    _tabSwitchController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Content fade animation
    _contentFadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _tabSwitchController,
      curve: Curves.easeInOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _contentFadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _contentFadeController,
      curve: Curves.easeOutBack,
    ));

    // Start initial animation
    _contentFadeController.forward();
  }

  @override
  void dispose() {
    _tabSwitchController.dispose();
    _contentFadeController.dispose();
    super.dispose();
  }

  void _getCurrentUser() {
    setState(() {
      _currentUser = FirebaseAuth.instance.currentUser;
    });
  }

  Future<void> _logout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  _isLoading = true;
                });

                try {
                  await FirebaseAuth.instance.signOut();
                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error logging out. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Admin Code Verification Dialog
  Future<void> _showAdminCodeDialog() async {
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        bool isVerifying = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Icon(Icons.security, color: Colors.blue[600]),
                  const SizedBox(width: 8),
                  const Text('Admin Access'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter admin code to access admin panel:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: codeController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Admin Code',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabled: !isVerifying,
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty && !isVerifying) {
                        _verifyAdminCode(
                            codeController.text, context, setDialogState,
                            (bool value) {
                          setDialogState(() {
                            isVerifying = value;
                          });
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isVerifying
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isVerifying || codeController.text.isEmpty
                      ? null
                      : () {
                          _verifyAdminCode(
                              codeController.text, context, setDialogState,
                              (bool value) {
                            setDialogState(() {
                              isVerifying = value;
                            });
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF34A853),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isVerifying
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Verify',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Verify Admin Code against Firestore
  Future<void> _verifyAdminCode(String enteredCode, BuildContext dialogContext,
      StateSetter setDialogState, Function(bool) setVerifying) async {
    setVerifying(true);

    try {
      // Query Firestore for the admin code
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('Admin').doc('ID').get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String storedCode = data['SID']?.toString() ?? '';

        if (enteredCode == storedCode) {
          // Code matches - close dialog and navigate
          Navigator.of(dialogContext).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EventConnectAdminPage(),
            ),
          );

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Access granted!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // Code doesn't match
          _showErrorDialog(
              dialogContext, 'Invalid admin code. Please try again.');
        }
      } else {
        // Document doesn't exist
        _showErrorDialog(dialogContext, 'Admin configuration not found.');
      }
    } catch (e) {
      // Error occurred
      _showErrorDialog(dialogContext, 'Error verifying code: ${e.toString()}');
    } finally {
      setVerifying(false);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    Navigator.of(context).pop(); // Close the admin code dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red[600]),
              const SizedBox(width: 8),
              const Text('Access Denied'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onTabTapped(int index) async {
    if (_selectedIndex != index) {
      // Start exit animation
      await _contentFadeController.reverse();

      setState(() {
        _selectedIndex = index;
      });

      // Start tab switch animation
      _tabSwitchController.forward().then((_) {
        _tabSwitchController.reset();
      });

      // Start enter animation
      _contentFadeController.forward();
    }
  }

  Widget _getSelectedTabContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildOverviewContent();
      case 1:
        return const SchedulePage();
      case 2:
        return const SpeakersPage();
      case 3:
        return const LocationPage();
      default:
        return _buildOverviewContent();
    }
  }

  // Custom Badge Widget for Notification Icon
  Widget _buildNotificationIconWithBadge() {
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.grey[800],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecentUpdatePage(),
              ),
            );
          },
        ),
        if (totalNotificationCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1),
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                totalNotificationCount > 99
                    ? '99+'
                    : totalNotificationCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'AsRES 2025',
          style: TextStyle(
            color: Color(0xFF4285F4),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF4285F4)),
        actions: [
          _buildNotificationIconWithBadge(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4285F4), Color(0xFF34A853)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.blue[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _currentUser?.displayName ?? 'User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _currentUser?.email ?? 'No email',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutAsRESPage()));
                // Navigate to settings page
              },
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('Admin Panel'),
              onTap: () {
                Navigator.pop(context); // Close drawer first
                _showAdminCodeDialog(); // Show admin code dialog
              },
            ),
            const Divider(),
            ListTile(
              leading: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.logout, color: Colors.red),
              title: Text(
                _isLoading ? 'Logging out...' : 'Logout',
                style: const TextStyle(color: Colors.red),
              ),
              onTap: _isLoading ? null : _logout,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Enhanced Navigation Tabs with animations
          // Replace the existing tab navigation section in your build method with this code:

// Enhanced Navigation Tabs with scrollable functionality
          // Replace the existing tab navigation section in your build method with this code:

// Enhanced Navigation Tabs with scrollable functionality
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              //padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: _tabs.asMap().entries.map((entry) {
                  int index = entry.key;
                  String tab = entry.value;
                  bool isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () => _onTabTapped(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      constraints: const BoxConstraints(
                        minWidth: 75, // Minimum width for each tab
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected
                                ? Color(0xFF34A853)
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        gradient: isSelected
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF34A853).withOpacity(0.2),
                                  Color(0xFF4285F4).withOpacity(0.05),
                                ],
                              )
                            : null,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: isSelected ? 17 : 16,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.normal,
                          color: isSelected
                              ? const Color(0xFF34A853)
                              : Colors.grey[600],
                        ),
                        child: Text(
                          tab,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Animated content based on selected tab
          Expanded(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(_contentFadeController),
                      child: _getSelectedTabContent(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About AsRES Section (New - Top of Overview Page)
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4285F4), Color(0xFF34A853)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.apartment_rounded,
                                color: Colors.white, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'About AsRES',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'The Asian Real Estate Society (AsRES) is the premier academic and professional organization dedicated to advancing real estate research, education, and practice across the Asia-Pacific region.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Founded to bridge the gap between academia and industry, AsRES brings together leading researchers, practitioners, and policymakers.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Event Header with enhanced animation
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4285F4), Color(0xFF34A853)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4285F4).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AsRES 2025',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '3 Day Conference',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildEventInfoRow(
                                    Icons.calendar_today, '09-07-2025'),
                                const SizedBox(height: 8),
                                _buildEventInfoRow(
                                    Icons.calendar_today, '10-07-2025'),
                                const SizedBox(height: 8),
                                _buildEventInfoRow(
                                    Icons.calendar_today, '11-07-2025'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildEventInfoRow(
                                    Icons.access_time, '08:30 AM'),
                                const SizedBox(height: 8),
                                _buildEventInfoRow(
                                    Icons.access_time, '09:00 AM'),
                                const SizedBox(height: 8),
                                _buildEventInfoRow(
                                    Icons.access_time, '07:00 AM'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildEventInfoRow(
                          Icons.location_on, 'Melbourne Business School'),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Event Details Section with staggered animation
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
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
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.grey[700], size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Event Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Site Visit Info
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
                              Text(
                                'Day 1 - Site Visit',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Melbourne-based project with a decarbonization and net-zero focus (500 Bourke St): 15:45 – 18:00pm\n\n(Limited seats on first come first serve basis, Registration required)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Papers and Sessions Info
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Conference Statistics',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Peer reviewed papers: 45 (9 sessions)\nPhD: 15 (3 sessions)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Sessions:',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Day 1 – 9 (3 PhD sessions = 15 papers, 3 peer reviewed = 15 papers, 3 non-peer reviewed = 18 papers) = 48 papers\n\nDay 2 – 10 (6 peer reviewed sessions = 30 papers; 4 non-peer reviewed sessions = 20 papers) = 50 papers\n\nDay 3 – 18 (18 non peer-reviews = 90 papers)\n\nTotal: 188 papers',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Recent Updates Section with delayed animation
        ],
      ),
    );
  }

  Widget _buildEventInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateItem(String title, String date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
            color: Color(0xFF4285F4),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
