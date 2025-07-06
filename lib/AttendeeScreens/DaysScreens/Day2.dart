import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Day2july10Screen extends StatefulWidget {
  const Day2july10Screen({super.key});

  @override
  State<Day2july10Screen> createState() => _Day2july10ScreenState();
}

class _Day2july10ScreenState extends State<Day2july10Screen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Method to check if text contains search query
  bool _containsSearchQuery(String text) {
    if (_searchQuery.isEmpty) return true;
    return text.toLowerCase().contains(_searchQuery.toLowerCase());
  }

  // Method to highlight search terms
  Widget _buildHighlightedText(String text, {TextStyle? style}) {
    if (_searchQuery.isEmpty) {
      return Text(text, style: style);
    }

    final query = _searchQuery.toLowerCase();
    final textLower = text.toLowerCase();

    if (!textLower.contains(query)) {
      return Text(text, style: style);
    }

    final spans = <TextSpan>[];
    int start = 0;
    int indexOfHighlight = textLower.indexOf(query, start);

    while (indexOfHighlight >= 0) {
      // Add text before highlight
      if (indexOfHighlight > start) {
        spans.add(TextSpan(
          text: text.substring(start, indexOfHighlight),
          style: style,
        ));
      }

      // Add highlighted text
      spans.add(TextSpan(
        text: text.substring(indexOfHighlight, indexOfHighlight + query.length),
        style: (style ?? const TextStyle()).copyWith(
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
      ));

      start = indexOfHighlight + query.length;
      indexOfHighlight = textLower.indexOf(query, start);
    }

    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: style,
      ));
    }

    return RichText(text: TextSpan(children: spans));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Day 2 - July 10'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey[800],
          elevation: 0,
        ),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDayHeader(
                          'Day Two – 10th July 2025', 'Marriott Docklands'),
                      const SizedBox(height: 16),
                      buildSearchBar(),
                      const SizedBox(height: 16),
                      buildMorningSchedule(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: const Color(0xFF4285F4),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xFF4285F4),
                    tabs: const [
                      Tab(text: 'Pre-Lunch Sessions'),
                      Tab(text: 'Post-Lunch Sessions'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              buildPreLunchSessions(),
              buildPostLunchSessions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search sessions, speakers, topics...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
            ),
        ],
      ),
    );
  }

  Widget buildDayHeader(String day, String venue) {
    if (_searchQuery.isNotEmpty && !_containsSearchQuery('$day $venue')) {
      return const SizedBox.shrink();
    }

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
          _buildHighlightedText(
            day,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          _buildHighlightedText(
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

  Widget buildMorningSchedule() {
    List<Widget> visibleSlots = [];

    // Add morning schedule items only if they match search
    final morningItems = [
      {'time': '8:30 - 9:00', 'title': 'Registration', 'description': ''},
      {
        'time': '9:00 - 9:15',
        'title': 'Welcome',
        'description':
            'Professor Julie Willis, Dean Faculty of Architecture, Building and Planning, The University of Melbourne'
      },
      {
        'time': '9:15 - 10:00',
        'title': 'Keynote Speech',
        'description':
            'Professor Naoyuki Yoshino, Professor Emeritus of Economics, Keio University\nFormer Dean, Asian Development Bank Institute'
      },
      {
        'time': '10:00 - 10:15',
        'title': 'Keynote Speech',
        'description': 'Deputy Lord Mayor Roshena Campbell, City of Melbourne'
      },
      {
        'time': '10:15 - 11:00',
        'title': 'Keynote Speech',
        'description':
            'REITs 4.0: new frontiers of global securitisation in the real asset economy\nSpeaker: Peter Verwer'
      },
      {'time': '11:00 - 11:30', 'title': 'Coffee Break', 'description': ''},
    ];

    for (var item in morningItems) {
      if (_containsSearchQuery(
          '${item['time']} ${item['title']} ${item['description']}')) {
        visibleSlots.add(
            buildTimeSlot(item['time']!, item['title']!, item['description']!));
      }
    }

    // Add panel discussion if it matches search
    if (_containsSearchQuery(
        'Panel Discussion Emerging trends in property finance and investment Jack Jiang Christina Jiang Jeff Davies Wendy Fergie Ke Lu Robert Edelstein')) {
      visibleSlots.add(buildPanelDiscussion());
    }

    if (visibleSlots.isEmpty && _searchQuery.isNotEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHighlightedText(
              'Morning Schedule - Venue: Palladium',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(height: 16),
            ...visibleSlots,
          ],
        ),
      ),
    );
  }

  Widget buildPanelDiscussion() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHighlightedText(
            '11:30 - 12:30: Panel Discussion',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          _buildHighlightedText(
            'Emerging trends in property finance and investment',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          _buildHighlightedText(
              'Moderator: Jack Jiang, Director Wealth Pi Fund'),
          _buildHighlightedText(
              'Presentation: Christina Jiang, Director Wealth Pi Fund'),
          const SizedBox(height: 8),
          _buildHighlightedText('Panellists:',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          _buildHighlightedText(
              '• Jeff Davies, Director, KordaMentha Real Estate'),
          _buildHighlightedText('• Wendy Fergie, CIO, Wealth Pi Fund'),
          _buildHighlightedText('• Ke Lu, Director, 16MC Development'),
          _buildHighlightedText(
              '• Professor Robert Edelstein, Professor Emeritus, Maurice Mann Chair in Real Estate, Co-Chair, Fisher Center for Real Estate & Urban Economics, Haas School of Business, University of California'),
          const SizedBox(height: 8),
          _buildHighlightedText(
            'Session will discuss emerging trends and innovations in real estate investment, development, and finance.',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget buildPreLunchSessions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (_containsSearchQuery(
              'Transport and Housing Janet Ge Yaopei Wang Desmond Tsang Zhankun Chen Xin Janet Ge Pei-Syuan Lin Tien Foo Sing'))
            buildSessionCard(
              'Session: Transport and Housing',
              'Chair: Janet Ge',
              'Venue: Palladium 1',
              [
                'The Impact of the New Mass Rail Transit Line on the Return and Risk of Residential Real Estate – Yaopei Wang',
                'The Unintended Social Consequences of High-Speed Rail: Evidence from Crime in China - Desmond Tsang; Zhankun Chen',
                'The improvement of transportation infrastructure and the Sydney property market – Xin Janet Ge',
                'Mobility and Fertility: Evidence from High-Speed Rail in Taiwan - Pei-Syuan Lin; Tien Foo Sing',
              ],
            ),
          const SizedBox(height: 16),
          if (_containsSearchQuery(
              'Data and Technology Shuya Yang Soonmahn Park Eunhye Beak Jae Won Kang Ziyi Bian Saurabh Verma'))
            buildSessionCard(
              'Session: Data and Technology',
              'Chair: Shuya Yang',
              'Venue: Palladium 2',
              [
                'Are Data Centers Hate Facilities? - Focusing on South Korea\'s housing prices - Soonmahn Park',
                'Digital Marketing in the Property Sector: Navigating Opportunities and Challenges – Eunhye Beak; Jae Won Kang',
                'Identifying Urban Residential Pain Points Based on People\'s Daily Online Text – Ziyi Bian',
                'Determinants of office building rents in the cities of developing countries: A case study of India\'s National Capital Region (NCR) - Saurabh Verma',
              ],
            ),
          const SizedBox(height: 16),
          if (_containsSearchQuery('Lunch'))
            buildTimeSlot('12:30 - 13:30', 'Lunch', 'Venue: Palladium'),
        ],
      ),
    );
  }

  Widget buildPostLunchSessions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHighlightedText(
            '13:30 - 15:00 Sessions',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (_containsSearchQuery(
              'Housing Tsur Somerville Alaknanda Menon Yanhao Ding Ying Fan Norifumi Yukutake Jyoti Shukla Piyush Tiwari Masatomo Suzuki'))
            buildSessionCard(
              'Session: Housing',
              'Chair: Tsur Somerville',
              'Venue: Palladium 1',
              [
                'An Ecosystems approach to solving the affordable housing crisis: A case of Global Housing Technology Challenge India - Alaknanda Menon (Discussant: Ying Fan)',
                'Housing Affordability Program and Household Financial Market Participation: Evidence from China - Yanhao Ding (Discussant: Alaknanda Menon)',
                'The economics of urban redevelopment: Price gradient, spatial structure, and spillover - Ying Fan (Discussant: Tsur Somerville)',
                'The Effects of Temporary Housing Provision on Recovery of Well-being in Major Disaster - Norifumi Yukutake, Jyoti Shukla, Piyush Tiwari (Discussant: Tsur Somerville)',
                'Empty Homes, Vacancy Taxes, and Housing Affordability - Tsur Somerville (Discussant: Masatomo Suzuki)',
              ],
            ),
          const SizedBox(height: 16),
          if (_containsSearchQuery(
              'Market Behaviour Timothy Riddiough Jiayu Zhang Daizhong Tang Jingyi Wang Dongho Kim Hiroshi Ishijima'))
            buildSessionCard(
              'Session: Market Behaviour',
              'Chair: Timothy Riddiough',
              'Venue: Palladium 2',
              [
                'Search Frictions, Investment Strategies, and Performance in Private Equity - Timothy Riddiough (Discussant: Jiayu Zhang)',
                'The Golden Cage: How Real Estate Corporate Financialization Traps Firms in Debt Risk - Daizhong Tang; Jingyi Wang (Discussant: Dongho Kim)',
                'The Regulatory Role of Local Governments in Urban Renewal Funds in China: A Game Theory Approach - Jiayu Zhang (Discussant: Daizhong Tang)',
                'Hidden Costs of New Clean Technology: Risk Perception and Housing Price Adjustments - Dongho Kim (Discussant: Timothy Riddiough)',
                'A Note on the Pricing System for Real Estate and Financial Markets - Hiroshi Ishijima',
              ],
            ),
          const SizedBox(height: 16),
          if (_containsSearchQuery(
              'Policy Jyoti Shukla Rita Yi Man Li Dahai Liu Hainan Sheng'))
            buildSessionCard(
              'Session: Policy',
              'Chair: Jyoti Shukla',
              'Venue: Palladium 3',
              [
                'The impact of facilities on US property values - Rita Yi Man Li (Discussant: Jyoti Shukla)',
                'Evolution of China\'s Land Reclamation Policies and Strategies for Sustainable Governance - Dahai Liu (Discussant: Hainan Sheng)',
                'On well-being of households in Japan and post-disasters reinstatement - Jyoti Shukla, Norifumi Yukutake, Piyush Tiwari (Discussant: Rita Yi Man Li)',
                'Winners and Losers in Corrupt Markets: The Impact of Political Misconduct on Commercial Real Estate - Hainan Sheng (Discussant: Jyoti Shukla)',
              ],
            ),
          const SizedBox(height: 16),
          // Continue with other sessions...
          buildTimeSlot('15:00 - 15:30', 'Coffee Break', ''),
          const SizedBox(height: 16),
          _buildHighlightedText(
            '15:30 - 17:00 Sessions',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          buildEveningSessionsGrid(),
          const SizedBox(height: 16),
          if (_containsSearchQuery('Conference Dinner'))
            buildTimeSlot('19:00 - 21:00', 'Conference Dinner',
                'Venue: Marriott Docklands'),
        ],
      ),
    );
  }

  Widget buildEveningSessionsGrid() {
    List<Widget> visibleSessions = [];

    // Add sessions that match search criteria
    if (_containsSearchQuery(
        'Housing Bor-Ming Hsieh William K S Cheung Ming Shann Tsai Cheng Tang Low Sheau Ting Shu Ling Chiang')) {
      visibleSessions.add(
        buildSessionCard(
          'Session: Housing',
          'Chair: Bor-Ming Hsieh',
          'Venue: Palladium 1',
          [
            'Housing Price Surge in the Hsinchu Science Park Area: A Hi-Tech Boom or Speculative Flipping? - Bor-Ming Hsieh (Discussant: William K S Cheung)',
            'When Minds Lag Behind Markets: Policy Nudging and Expectation Formation in Housing Markets - William K S Cheung (Discussant: Ming Shann Tsai)',
            'The economic implications of map distortion: evidence from the housing market - Cheng Tang (Discussant: Bor-Ming Hsieh)',
            'What Matters Most? A Cross-Generation Study on Perceived Importance of Retirement Home Features and Services - Low Sheau Ting (Discussant: Cheng Tang)',
            'Analyzing Asymmetric Price Adjustments in Housing and Rental Markets with Threshold Models and Housing Market Attentions - Ming Shann Tsai; Shu Ling Chiang (Discussant: Bor-Ming Hsieh)',
          ],
        ),
      );
    }

    if (_containsSearchQuery(
        'Sustainability Raghu Tirumala Ameeta Jain Saurabh Verma Seonghun Min Eric Fesselmeyer Chai Duo')) {
      visibleSessions.add(
        buildSessionCard(
          'Session: Sustainability',
          'Chair: Raghu Tirumala',
          'Venue: Palladium 2',
          [
            'Opportunities and challenges in transitioning to renewable energy in commercial buildings in India - Raghu Tirumala; Ameeta Jain, Saurabh Verma (Discussant: Seonghun Min)',
            'Public Pool Usage as Adaptation Against Urban Heat in New York City - Eric Fesselmeyer (Discussant: Raghu Tirumala)',
            'The Impact of Urban Land Intensive Utilization on Carbon Emissions: Land Use Differentiation and Spatiotemporal Heterogeneity - Chai Duo (Discussant: Eric Fesselmeyer)',
            'Uncovering Green Premiums Over Time: A Dynamic Analysis of Certification Effects in Seoul\'s Housing Market - Seonghun Min (Discussant: Chai Duo)',
          ],
        ),
      );
    }

    // Add more sessions as needed...
    if (visibleSessions.isEmpty && _searchQuery.isNotEmpty) {
      return const SizedBox.shrink();
    }

    return Column(children: visibleSessions);
  }

  Widget buildTimeSlot(String time, String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: _buildHighlightedText(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF4285F4),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHighlightedText(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  _buildHighlightedText(
                    description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSessionCard(
      String title, String chair, String venue, List<String> presentations) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHighlightedText(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(height: 4),
            _buildHighlightedText(
              chair,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            _buildHighlightedText(
              venue,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ...presentations.map((presentation) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: _buildHighlightedText(
                    '• $presentation',
                    style: const TextStyle(fontSize: 11),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
