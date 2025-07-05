import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Day2july10Screen extends StatelessWidget {
  const Day2july10Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Day 2 - July 10'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDayHeader('Day Two – 10th July 2025', 'Marriott Docklands'),
            const SizedBox(height: 16),
            // Morning Sessions (Single Venue)
            buildMorningSchedule(),
            const SizedBox(height: 24),
            // Afternoon Sessions with Tabs
            buildAfternoonSchedule(),
          ],
        ),
      ),
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

  Widget buildMorningSchedule() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Morning Schedule - Venue: Palladium',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(height: 16),
            buildTimeSlot('8:30 - 9:00', 'Registration', ''),
            buildTimeSlot('9:00 - 9:15', 'Welcome',
                'Professor Julie Willis, Dean Faculty of Architecture, Building and Planning, The University of Melbourne'),
            buildTimeSlot('9:15 - 10:00', 'Keynote Speech',
                'Professor Naoyuki Yoshino, Professor Emeritus of Economics, Keio University\nFormer Dean, Asian Development Bank Institute'),
            buildTimeSlot('10:00 - 10:15', 'Keynote Speech',
                'Deputy Lord Mayor Roshena Campbell, City of Melbourne'),
            buildTimeSlot('10:15 - 11:00', 'Keynote Speech',
                'REITs 4.0: new frontiers of global securitisation in the real asset economy\nSpeaker: Peter Verwer'),
            buildTimeSlot('11:00 - 11:30', 'Coffee Break', ''),
            buildPanelDiscussion(),
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
          const Text(
            '11:30 - 12:30: Panel Discussion',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'Emerging trends in property finance and investment',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text('Moderator: Jack Jiang, Director Wealth Pi Fund'),
          const Text('Presentation: Christina Jiang, Director Wealth Pi Fund'),
          const SizedBox(height: 8),
          const Text('Panellists:',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const Text('• Jeff Davies, Director, KordaMentha Real Estate'),
          const Text('• Wendy Fergie, CIO, Wealth Pi Fund'),
          const Text('• Ke Lu, Director, 16MC Development'),
          const Text(
              '• Professor Robert Edelstein, Professor Emeritus, Maurice Mann Chair in Real Estate, Co-Chair, Fisher Center for Real Estate & Urban Economics, Haas School of Business, University of California'),
          const SizedBox(height: 8),
          const Text(
            'Session will discuss emerging trends and innovations in real estate investment, development, and finance.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget buildAfternoonSchedule() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
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
            child: const TabBar(
              labelColor: Color(0xFF4285F4),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF4285F4),
              tabs: [
                Tab(text: 'Pre-Lunch Sessions'),
                Tab(text: 'Post-Lunch Sessions'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 800,
            child: TabBarView(
              children: [
                buildPreLunchSessions(),
                buildPostLunchSessions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPreLunchSessions() {
    return SingleChildScrollView(
      child: Column(
        children: [
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
          buildTimeSlot('12:30 - 13:30', 'Lunch', 'Venue: Palladium'),
        ],
      ),
    );
  }

  Widget buildPostLunchSessions() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            '13:30 - 15:00 Sessions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
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
          Row(
            children: [
              Expanded(
                child: buildSessionCard(
                  'Session: Planning and Regulation',
                  'Chair: Ameeta Jain',
                  'Venue: Dock',
                  [
                    'Intra-household Bargaining and Fertility Decision-making: Evidence from Homeownership Structure and Housing Price Shocks in China – Boyuan Huang; Rongjie Zhang; Lin; Jing Wu (Discussant: Shuya Yang)',
                    'Regulatory controls, housing supply and the pandemic: evidence from Australia - Shuya Yang',
                    'Research on area management strategies in emerging Asian city - Targeting a commercial facility event in Binh Duong, Vietnam - Naoya Sato (Discussant: Boyuan Huang)',
                    'The Housing Burden of Entrepreneurial Cities: Evidence from China\'s Technology Hub Hangzhou - Shuai Shi (Discussant: Ameeta Jain)',
                    'Ethnic Diversity and Housing Market Resilience after Natural Disasters: Evidence from Australia - Ameeta Jain; Qiang Li (Discussant: Shuai Shi)',
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: buildSessionCard(
                  'Session: Market Behaviour',
                  'Chair: Edward Chi Ho Tang',
                  'Venue: Observatory',
                  [
                    'Nudging approach for fostering sustainable practices among building users - Weng Wai Choong; Sheau Ting Low (Discussant: Edward Tang)',
                    'The Impact of the Illusory Truth Effect on Taiwan\'s Real Estate Market: Repeated Exposure to Fake News, Fact-Checking, and Motivated Reasoning - Jing-Yi Chen (Discussant: Weng Wai Choong)',
                    'Buzz as the Signal? Exploring Real Estate Market Trends through Social Sentiment and ChatGPT-Powered Semantic Analysis - Nanyu Chu (Discussant: Jing-Yi Chen)',
                    'Good things come in pairs? Block Trade in Housing Market - Edward Chi Ho Tang (Discussant: Nanyu Chu)',
                    'Office Space Management Post COVID-19 Pandemic in Kuala Lumpur - Mohd Fitry bin Hassim (Discussant: Edward Chi Ho Tang)',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          buildTimeSlot('15:00 - 15:30', 'Coffee Break', ''),
          const SizedBox(height: 16),
          const Text(
            '15:30 - 17:00 Sessions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          buildEveningSessionsGrid(),
          const SizedBox(height: 16),
          buildTimeSlot('19:00 - 21:00', 'Conference Dinner',
              'Venue: Marriott Docklands'),
        ],
      ),
    );
  }

  Widget buildEveningSessionsGrid() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildSessionCard(
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
            ),
            const SizedBox(width: 8),
            Expanded(
              child: buildSessionCard(
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
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildSessionCard(
                'Session: Housing Finance',
                'Chair: Weida Kuang',
                'Venue: Palladium 3',
                [
                  'A Study on the Causality of Reverse Mortgage, GDP, and Housing Price using Bootstrap Fourier Granger Causality in Quantiles - Ming-Che Wu (Discussant: Ling Zhang)',
                  'Decrease in Mortgage Payments, Where Does the Money Go? — An Empirical Analysis of Household Consumption Distribution and Saving Behavior - Pei-Syuan Lin (Discussant: Weida Kuang)',
                  'Exploring the Threshold Effects in Foreclosure Recovery Rate and Foreclosure Lag Distributions - Shu Ling Chiang; Ming Shann Tsai (Discussant: Pei-Syuan Lin)',
                  'Housing price expectation and default risk of real estate firms - Weida Kuang, Yongman WuDuo (Discussant: Ming-Che Wu)',
                  'The Development Differences of Districts and the Boundary Effect of Housing Prices in Hangzhou, China - Ling Zhang (Discussant: Weida Kuang)',
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: buildSessionCard(
                'Session: Housing',
                'Chair: Shotaro Watanabe',
                'Venue: Dock',
                [
                  'Asset Accumulation in Low-Income Households: Divergent Effects of Housing Assistance Schemes in South Korea - Ji-Na Kim (Discussant: Rita Yi Man Li)',
                  'Willingness to Pay for Senior Housing: Evidence from Two Coastal Chinese Cities - Rita Yi Man Li (Discussant: Jyoti Shukla)',
                  'Examining housing satisfaction through the lens of \'capability approach\': Case of Japan - Jyoti Shukla, Piyush Tiwari, Norifumi Yukutake (Discussant: Shotaro Watanabe)',
                  'Parental Default Strategies and Their Financial Legacy: Asset Accumulation and Debt Behaviour in the Next Generation - Shotaro Watanabe (Discussant: Yilan Luo)',
                  'Electricity Supply Uncertainty in the City: Perceived Risks, Housing Market Reactions, and Migration Patterns - Yilan Luo (Discussant: Shotaro Watanabe)',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        buildSessionCard(
          'Session: Affordability',
          'Chair: Jae Won Kang',
          'Venue: Observatory',
          [
            'Evaluating the Impact of Federal Government Housing Policies on Affordability and Market Dynamics in Australia – Jae Won Kang (Discussant: Hyung Min Kim)',
            'The effect of Affordable housing on the mobility of Entrepreneurial Talent – Jianshuang Fan (Discussant: Minghng Yu)',
            'Policy-induced Housing Market Segmentation and Young Homebuyers\' Trade-offs: Evidence from Singapore\'s Presale Public Housing Reform – Minghang Yu (Discussant: Jae Won Kang)',
            'Transitioning from Informal to Formal Settlements: A Case Study of Manseok-dong, Incheon – Hee Jin Yang (Discussant: Jae Won Kang)',
            'The Irony of Formalisation of Informal Settlements: A Case Study of 104 Village in Seoul, South Korea – Hyung Min Kim (Discussant: Hee Jin Yang)',
          ],
        ),
      ],
    );
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
            child: Text(
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
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
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
              venue,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ...presentations.map((presentation) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
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
