import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Day1july9Screen extends StatefulWidget {
  const Day1july9Screen({super.key});

  @override
  State<Day1july9Screen> createState() => _Day1july9ScreenState();
}

class _Day1july9ScreenState extends State<Day1july9Screen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget buildSearchWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        decoration: const InputDecoration(
          hintText: 'Search sessions, speakers, or topics...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Color(0xFF4285F4)),
          suffixIcon: Icon(Icons.filter_list, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Day 1 - July 9'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
      ),
      body: buildMainSessions(),
    );
  }

  Widget buildDayHeader(String day, String venue) {
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

  Widget buildOpeningSession() {
    // Check if opening session content matches search query
    if (_searchQuery.isNotEmpty) {
      String searchableContent =
          'Opening Session Registration Welcome Professor Jenny George Dean Melbourne Business School Keynote Speech Accelerating Real Estate Capital Dealmaking AI Era Jason F. Yong Chief Investment Officer CapitalxWise Venue All Rooms Marra LT1 LT4';
      if (!searchableContent.toLowerCase().contains(_searchQuery)) {
        return const SizedBox.shrink();
      }
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Opening Session',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(height: 16),
            buildTimeSlot('8:30 - 9:50', 'Registration', ''),
            buildTimeSlot('8:50 - 9:00', 'Welcome',
                'Professor Jenny George, Dean Melbourne Business School'),
            buildKeynoteSession(),
          ],
        ),
      ),
    );
  }

  Widget buildKeynoteSession() {
    if (_searchQuery.isNotEmpty) {
      String searchableContent =
          'Keynote Speech Accelerating Real Estate Capital Dealmaking AI Era Jason F. Yong Chief Investment Officer CapitalxWise Venue All Rooms Marra LT1 LT4';
      if (!searchableContent.toLowerCase().contains(_searchQuery)) {
        return const SizedBox.shrink();
      }
    }

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
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
              children: _buildHighlightedText('9:00 - 9:45: Keynote Speech'),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
              children: _buildHighlightedText(
                  'Accelerating Real Estate Capital & Dealmaking in an AI Era'),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText(
                  'Speaker: Jason F. Yong, Chief Investment Officer, CapitalxWise'),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey),
              children:
                  _buildHighlightedText('Venue: All Rooms (Marra, LT1, LT4)'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMainSessions() {
    return DefaultTabController(
      length: 4,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // Day header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: buildDayHeader(
                    'Day One – 9th July 2025', 'Melbourne Business School'),
              ),
            ),
            // Search widget
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: buildSearchWidget(),
              ),
            ),
            // Opening session
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: buildOpeningSession(),
              ),
            ),
            // Pinned tabs
            SliverAppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 60,
              flexibleSpace: Container(
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
                margin: const EdgeInsets.all(8),
                child: const TabBar(
                  labelColor: Color(0xFF4285F4),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Color(0xFF4285F4),
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Morning Sessions'),
                    Tab(text: 'Afternoon Sessions'),
                    Tab(text: 'Evening Sessions'),
                    Tab(text: 'Masterclass'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            buildMorningSessions(),
            buildAfternoonSessions(),
            buildEveningSessions(),
            buildMasterclass(),
          ],
        ),
      ),
    );
  }

  Widget buildMorningSessions() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            '9:45 - 11:15 Sessions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildSessionCard(
                  'PhD Colloquium I',
                  'Chair: Kazuto Sumita',
                  'Room: Marra',
                  [
                    'The neglected cost: Ecological consequences of urban expansion from a triple-coupling perspective - Weilong Kong (Discussant: Kazuto Sumita)',
                    'Urban compactness and carbon emissions: A novel insight based on urban scaling law - Jinfang Pu (Discussant: Kazuto Sumita)',
                    'Analysis of Policy Effectiveness for curbing Real Estate Speculation in Korea – Seoul City Land Transaction Permit System - Kyung-hyun Park (Discussant: Jae Won Kang)',
                    'Barriers to the implementation of passive retrofitting of residential buildings: A comparative analysis of operational-level-stakeholders\' perceptions - Ayodele Adegoke (Discussant: Jae Won Kang)',
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: buildSessionCard(
                  'Master Class (Net Zero Cities)',
                  'See Masterclass Tab',
                  'Room: LT1',
                  [
                    'Program details available in Masterclass tab',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          buildSessionCard(
            'PhD Colloquium 2',
            'Chair: Yang Shi',
            'Room: LT4',
            [
              'Exploring Risks in Overseas Real Estate Investment: Challenges and Strategies for Taiwanese Investors - Po-Wei Fu (Discussant: Yang Shi)',
              'Exploring the Application of TNFD in Real Estate Development: The Case of Swire Properties, Hong Kong - Ge-Ting Yan (Discussant: Yang Shi)',
              'The development of the REITs and RWA: Lessons from Taiwan - Wen-Jia Su (Discussant: Yang Shi)',
              'The motivational factors affecting housing development projects within communities on land with long-term leasehold rights: A case study of the Tap Pra Tan housing community in Bangkok, Thailand - Amaraporn Khaikham; Pornraht Pongprase (Discussant: Yang Shi)',
              'Urban Greenery and Real Estate Price - Thomas Chen (Discussant: Yang Shi)',
            ],
          ),
          const SizedBox(height: 16),
          buildTimeSlot('11:15 - 11:30', 'Coffee Break', ''),
          const SizedBox(height: 16),
          const Text(
            '11:30 - 13:00 Sessions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildSessionCard(
                  'PhD Colloquium 3',
                  'Chair: Janet Ge',
                  'Room: Marra',
                  [
                    'Place-based policy and revitalization of resource-based cities - Policy evaluation based on the National Sustainable Development Plan for Resource-based Cities (2013-2020) - Xiaoqi Liu (Discussant: Godwin Kavaarpuo)',
                    'Shanghai in Flux: Evaluating the Building Expansion Effects of River Crossings Using Satellite Imagery - Ze Wang (Discussant: Godwin Kavaarpuo)',
                    'Factors influencing housing purchase decision among the younger generation: A review of the Malaysia housing market - Seok Ying Chua (Discussant: Janet Ge)',
                    'Winners and Losers of Opportunity: Insights from a Low-Income Housing Lottery in the Philippines - Tomoki Nishiyama; Ze Wang (Discussant: Janet Ge)',
                    'Strategic collaborative framework in urban agriculture initiatives between local authorities and management of strata housing toward sustainable city - Nurulanis Ahmad; Zarita Ahmad; Yasmin Mohd Adnan',
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: buildSessionCard(
                  'PhD Colloquium 4',
                  'Chair: Samuel Swanzy-Impraim',
                  'Room: LT4',
                  [
                    'A study for factors for operating income and cap rates of JREITs in Tokyo - Kohei Tsujii',
                    'A study of change in people\'s perception in Ho Chi Minh city - Sayoko Hattori',
                    'Determinants of property value, cap rate, NOI in commercial properties owned by JREITs - Naoki Toyoyoshi',
                    'Benefits and challenges of blockchain technology in real estate A literature review - Dengjin Wu',
                    'Understanding Valuation Service Quality in a Developing Market - Uyanwaththe Gedara Geethika Nilanthi Kumari',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          buildTimeSlot('13:00 - 14:00', 'Lunch', ''),
        ],
      ),
    );
  }

  Widget buildAfternoonSessions() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            '14:00 - 15:30 Sessions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildSessionCard(
                  'Session: Financial Markets',
                  'Chair: Ming-Chi Chen',
                  'Room: Marra',
                  [
                    'Does Foreclosure have Spillover Effects on the Related Housing Market? - Shijun Liu, Weida Kuang',
                    'The Concentrated Real Estate Lending and its Impacts on Bank Performance - Fang-Ni Chu, Ming-Chi Chen',
                    'Housing Justice Improvement: Housing Tax Reform and Housing definancialization Taiwan experience - Ying-Hui Chiang',
                    'The Impact of Selective Credit Controls on Taiwan\'s Housing Market: Evidence from Panel Data 2001–2024 - Chih Yuan Yang',
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: buildSessionCard(
                  'Session: Sustainability',
                  'Chair: Saurabh Verma',
                  'Room: LT1',
                  [
                    'Cross-Regional Patent Network and Green Technology Evolution: Pathways Based on the "Relatedness-Complexity" Framework - Jianping Gu, Yayu Xu',
                    'Uncertainty Horizons: Investigating the Impact of Climate Policy on Housing Markets in 35 Major Chinese Cities - Jianing Wang',
                    'From policy to progression: Mapping India\'s energy policy landscape for a net zero built environment - Saurabh Verma',
                    'Sea level rise, collateral constraints, and entrepreneurship - Liuming Yang',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          buildSessionCard(
            'Session: Commercial Real Estate',
            'Chair: Tien Foo Sing',
            'Room: LT4',
            [
              'Retail Vacancy and Property Value in Shrinking Cities: A Case Study of Small-Sized Cities in Korea - Jeongseob Kim',
              'Risk-Taking Behavior of Foreign Investors in Commercial Real Estate Markets - Tien Foo Sing',
              'Tariffs on the Move: Unpacking Their Impact on Asia Pacific Logistics Hubs - Benedict Lai, Sandy Padilla',
              'Determinants of Warehouse Rents in India - Prashant Das; Pritha Dev',
            ],
          ),
          const SizedBox(height: 16),
          buildTimeSlot('15:30 - 15:45', 'Coffee Break', ''),
        ],
      ),
    );
  }

  Widget buildEveningSessions() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            '15:45 - 17:15 Sessions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildSessionCard(
                  'PhD Colloquium 5',
                  'Chair: Desmond Tsang',
                  'Room: Marra',
                  [
                    'Measuring the well-being of individuals living in social housing through capability approach - Farzaneh Janakipour (Discussant: Desmond Tsang)',
                    'Developing A Framework to Mitigate Stigmatized Property Overhang in High-Rise Residential - Noor Farhana Akrisha Ishak, Zarita Ahmad (Discussant: Desmond Tsang)',
                    'Formulating a stigmatized dimension of residential properties overhang model from the purchasers\' perspective in Selangor - Norulelin Huri, Zarita Ahmad (Discussant: Desmond Tsang)',
                    'Time-varying Spillover Effects of House Prices: a Case Study of Metropolitan NSW - Dongkai Li, Janet Ge (Discussant: Wayne Wan)',
                    'Dynamic Interactions Between Pre-sale and Existing Housing Markets - Chiu-Ming Shen (Discussant: Wayne Wan)',
                    'Strategic Real Estate Investment Decision-Making Framework for Institutional Investors in Malaysia - Fatin Aziz',
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: buildSessionCard(
                  'Session: Real Estate in Asia',
                  'Chair: Hyunmin Kim',
                  'Room: LT1',
                  [
                    'When a Measure Becomes a Target: Local Governments\' strategic responses to Price Stability Target in Chinese Housing Market - Jiaxin Zheng, Rongjie Zhang, Jing Wu (Discussant: Godwin Kavaarpuo)',
                    'Impact of Fertility Relaxation on the Housing Market Outcomes - Keyang Li, Yixun Tang, Qiuyi Wang (Discussant: Janet Ge)',
                    'Competitive Investment in Human Capital: The Case of "Good School" Premium in Housing Prices - Jing Wu, Rongjie Zhang',
                    'Household-level determinants of vacant housing: Evidence from a nationwide survey in Japan - Masatomo Suzuki, Norifumi Yukutake',
                    'Analyzing the Impact of Fourth Industrial Revolution Technology on Real Estate Industry Productivity in South Korea - Soonmahn Park, Young-Hyuck Kim',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          buildSessionCard(
            'Session: Sustainability',
            'Chair: Ashish Gupta',
            'Room: LT4',
            [
              'Decoding LEED Platinum Certification: The critical Role of Onsite and Offsite Renewable Energy Adoption in Commercial Buildings - Akshay Bhardawaj, Saurabh Verma (Discussant: Ashish Gupta)',
              'Does Green Building Really Deliver? Unpacking Strategic Scoring Behaviors in China\'s Green Building Certification System - Jing Wu; Xinru Wu (Discussant: Ashish Gupta)',
              'Exploring the Determinants of Real Estate Developers\' Decisions in Pursuing Net Zero Buildings in Thailand - Satapat Kanchong; Pornraht Pongprase (Discussant: Ashish Gupta)',
              'Material Recycling and Reuse situation in Building Demolition - Bowen Jiang, Jing Wu, Rongjie Zhang',
              'Are Property Markets Prepared for Climate Change Adaptation? The Impacts of Flood Risk and Early Warning Systems on Property Values in South Korea - Gyojun Shin',
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Evening Events',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          buildEventCard([
            buildTimeSlot('17:15 - 19:00', 'Visit to MSDx',
                'Exhibition of students works at Melbourne School of Design, Glyn Davis Building (optional and self-guided)'),
            buildTimeSlot(
                '17:00 - 18:00', 'AsRES Board Meeting 1', 'On invitation only'),
            buildTimeSlot(
                '18:00 - 19:00', 'AsRES Board Meeting 2', 'On invitation only'),
            buildTimeSlot('19:00 - 21:00', 'Welcome Reception',
                'University House, Law Building, University of Melbourne, Parkville Campus'),
          ]),
          const SizedBox(height: 16),
          buildSpecialEvent(),
        ],
      ),
    );
  }

  Widget buildMasterclass() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Masterclass Program (Net Zero Cities)',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4285F4)),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTimeSlot('8:45 - 9:00', 'Welcome',
                      'Professor Jenny George, Dean, Melbourne Business School'),
                  buildTimeSlot('9:00 - 9:45', 'Keynote',
                      'Accelerating Real Estate Capital & Dealmaking in an AI Era\nJason F. Yong, Chief Investment Officer, CapitalxWise'),
                  buildMasterclassSession(
                      '9:45 - 10:15',
                      'Equivalence of Carbon Pricing, Green Bond and Carbon Tax to Achieve Net Zero Cities',
                      'Professor Naoyuki Yoshino\nProfessor Emeritus of Economics, Keio University, Special Professor Tokyo Metropolitan University,\nFormer Dean, Asian Development Bank Institute'),
                  buildMasterclassSession(
                      '10:15 - 10:45',
                      'Code versus code: how AI can deliver faster, smarter and sustainable urban planning outcomes',
                      'Peter Verwer, AO'),
                  buildMasterclassSession(
                      '10:45 - 11:15',
                      'Reshaping the City: Mapping the Next Chapter of Office Strategy in Sydney and Melbourne',
                      'Lin Lee\nCushman and Wakefield'),
                  buildTimeSlot('11:15 - 11:30', 'Tea Break', ''),
                  buildMasterclassSession('11:30 - 11:45', 'Climate Finance',
                      'Dr Raghu Tirumala\nUniversity of Melbourne'),
                  buildMasterclassSession(
                      '11:45 - 12:00',
                      'Reimagining Net Zero Cities: policies for greener, healthier and equitable communities',
                      'Professor Piyush Tiwari\nUniversity of Melbourne'),
                  buildMasterclassPanel(),
                  buildTimeSlot('13:00 - 14:00', 'Lunch Break', ''),
                  buildSiteVisit(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMasterclassSession(String time, String title, String speaker) {
    if (_searchQuery.isNotEmpty) {
      String searchableContent = '$time $title $speaker';
      if (!searchableContent.toLowerCase().contains(_searchQuery)) {
        return const SizedBox.shrink();
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
              children: _buildHighlightedText('$time: $title'),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              children: _buildHighlightedText(speaker),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMasterclassPanel() {
    if (_searchQuery.isNotEmpty) {
      String searchableContent =
          'IRES Panel role Innovation driving sustainability Real Estate Professor Desmond Tsang CUHK Professor Quilin Ke UCL Professor Ashish Gupta RICSSBE India Dr Wayne Wan Monash Victoria Cook Yarra Valley Water';
      if (!searchableContent.toLowerCase().contains(_searchQuery)) {
        return const SizedBox.shrink();
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
              children: _buildHighlightedText('12:00 - 13:00: IRES Panel'),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black),
              children: _buildHighlightedText(
                  'The role of Innovation in driving sustainability in Real Estate'),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children:
                  _buildHighlightedText('Chair: Professor Desmond Tsang, CUHK'),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText('Panelists:'),
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText('• Professor Quilin Ke, UCL'),
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText(
                  '• Professor Ashish Gupta, RICSSBE, India'),
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText('• Dr Wayne Wan, Monash'),
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children:
                  _buildHighlightedText('• Victoria Cook, Yarra Valley Water'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSiteVisit() {
    if (_searchQuery.isNotEmpty) {
      String searchableContent =
          'Site Visit Melbourne-based project decarbonization net-zero focus Location 500 Bourke St Limited seats first come first serve basis Registration required';
      if (!searchableContent.toLowerCase().contains(_searchQuery)) {
        return const SizedBox.shrink();
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.purple),
              children: _buildHighlightedText('Day 1 - Site Visit'),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
              children: _buildHighlightedText(
                  'Melbourne-based project with a decarbonization and net-zero focus'),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText('Location: 500 Bourke St'),
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText('Time: 15:45 - 18:00'),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.red),
              children: _buildHighlightedText(
                  'Limited seats on first come first serve basis, Registration required'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSpecialEvent() {
    if (_searchQuery.isNotEmpty) {
      String searchableContent =
          'Special Site Visit Melbourne-based project decarbonization net-zero focus Location 500 Bourke St Limited seats first come first serve basis Registration required';
      if (!searchableContent.toLowerCase().contains(_searchQuery)) {
        return const SizedBox.shrink();
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.purple),
              children: _buildHighlightedText('Special Site Visit'),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
              children: _buildHighlightedText(
                  'Day 1 - Site Visit: Melbourne-based project with a decarbonization and net-zero focus'),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText('Location: 500 Bourke St'),
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: _buildHighlightedText('Time: 15:45 - 18:00'),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.red),
              children: _buildHighlightedText(
                  'Limited seats on first come first serve basis, Registration required'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeSlot(String time, String title, String description) {
    if (_searchQuery.isNotEmpty) {
      String searchableContent = '$time $title $description';
      if (!searchableContent.toLowerCase().contains(_searchQuery)) {
        return const SizedBox.shrink();
      }
    }

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
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color(0xFF4285F4),
                ),
                children: _buildHighlightedText(time),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    children: _buildHighlightedText(title),
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      children: _buildHighlightedText(description),
                    ),
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
      String title, String chair, String room, List<String> presentations) {
    // Filter presentations based on search query
    List<String> filteredPresentations = presentations.where((presentation) {
      if (_searchQuery.isEmpty) return true;
      return presentation.toLowerCase().contains(_searchQuery) ||
          title.toLowerCase().contains(_searchQuery) ||
          chair.toLowerCase().contains(_searchQuery) ||
          room.toLowerCase().contains(_searchQuery);
    }).toList();

    // If no matches found and search is active, don't show the card
    if (_searchQuery.isNotEmpty &&
        filteredPresentations.isEmpty &&
        !title.toLowerCase().contains(_searchQuery) &&
        !chair.toLowerCase().contains(_searchQuery) &&
        !room.toLowerCase().contains(_searchQuery)) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              chair,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Text(
              room,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...filteredPresentations.map((presentation) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 11, color: Colors.black),
                      children: _buildHighlightedText('• $presentation'),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // 6. Helper method for text highlighting
  List<TextSpan> _buildHighlightedText(String text) {
    if (_searchQuery.isEmpty) {
      return [TextSpan(text: text)];
    }

    List<TextSpan> spans = [];
    String lowerText = text.toLowerCase();
    String lowerQuery = _searchQuery.toLowerCase();

    int start = 0;
    int index = lowerText.indexOf(lowerQuery, start);

    while (index != -1) {
      // Add text before the match
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      // Add highlighted match
      spans.add(TextSpan(
        text: text.substring(index, index + _searchQuery.length),
        style: const TextStyle(
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ));

      start = index + _searchQuery.length;
      index = lowerText.indexOf(lowerQuery, start);
    }

    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return spans;
  }

  Widget buildEventCard(List<Widget> events) {
    // Filter events based on search query
    List<Widget> filteredEvents = [];

    if (_searchQuery.isEmpty) {
      filteredEvents = events;
    } else {
      for (Widget event in events) {
        // Since we can't directly access the content of the widgets,
        // we'll keep all events if any event might contain the search term
        // You might want to modify this based on your specific needs
        filteredEvents.add(event);
      }
    }

    if (filteredEvents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: filteredEvents,
        ),
      ),
    );
  }
}

// Add this method inside the _Day1july9ScreenState class, just before the closing brace }
