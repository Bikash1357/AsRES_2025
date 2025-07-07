import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Day1july9Screen extends StatefulWidget {
  const Day1july9Screen({super.key});

  @override
  State<Day1july9Screen> createState() => _Day1july9ScreenState();
}

class _Day1july9ScreenState extends State<Day1july9Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('Day 1 - July 9, 2025'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Masterclass'),
          ],
          indicatorColor: const Color(0xFF4285F4),
          labelColor: const Color(0xFF4285F4),
          unselectedLabelColor: Colors.grey[600],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildOverviewTab(),
          buildMasterclassTab(),
        ],
      ),
    );
  }

  Widget buildOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Day header
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildDayHeader(
                'Day One – 9 July 2025', 'Melbourne Business School'),
          ),

          // Opening session
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildOpeningSession(),
          ),

          // Time slot sessions
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildAllSessions(),
          ),

          // Site visit section
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildSiteVisitSection(),
          ),
        ],
      ),
    );
  }

  Widget buildMasterclassTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Day header
          Padding(
            padding: const EdgeInsets.all(16),
            child:
                buildDayHeader('Masterclass - Net Zero Cities', 'Venue: LT1'),
          ),

          // Masterclass content
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildMasterclassContent(),
          ),

          // Site visit section
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildSiteVisitSection(),
          ),
        ],
      ),
    );
  }

  Widget buildMasterclassContent() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masterclass Program (Net Zero Cities)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Venue: LT1',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            buildMasterclassTimeSlot(
                '08:45 - 9:00',
                'Welcome',
                'Professor Jenny George, Dean, Melbourne Business School',
                Colors.blue),
            buildMasterclassTimeSlot(
                '9:00 - 9:45',
                'Accelerating Real Estate Capital & Dealmaking in an AI Era',
                'Jason F. Yong, Chief Investment Officer, CapitalxWise',
                Colors.purple),
            buildMasterclassTimeSlot(
                '9:45 - 10:15',
                'Equivalence of Carbon Pricing, Green Bond and Carbon Tax to Achieve Net Zero Cities',
                'Professor Naoyuki Yoshino - Professor Emeritus of Economics, Keio University, Special Professor Tokyo Metropolitan University, Former Dean, Asian Development Bank Institute',
                Colors.green),
            buildMasterclassTimeSlot(
                '10:15 - 10:45',
                'Code versus code: how AI can deliver faster, smarter and sustainable urban planning outcomes',
                'Peter Verwer, AO',
                Colors.orange),
            buildMasterclassTimeSlot(
                '10:45 - 11:15',
                'Reshaping the City: Mapping the Next Chapter of Office Strategy in Sydney and Melbourne',
                'Lin Lee, Cushman and Wakefield',
                Colors.teal),
            buildCoffeeBreak('11:15 - 11:30 - Tea Break'),
            buildMasterclassTimeSlot('11:30 - 11:45', 'Climate Finance',
                'Dr Raghu Tirumala, University of Melbourne', Colors.indigo),
            buildMasterclassTimeSlot(
                '11:45 - 12:00',
                'Reimagining Net Zero Cities: policies for greener, healthier and equitable communities',
                'Professor Piyush Tiwari, University of Melbourne',
                Colors.pink),
            buildMasterclassPanel(),
            buildLunchBreak(), // Add lunch break here
          ],
        ),
      ),
    );
  }

  Widget buildMasterclassPanel() {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '12:00 - 13:00',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IRES Panel',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'The role of Innovation in driving sustainability in Real Estate',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Chair: Professor Desmond Tsang, CUHK'),
          const SizedBox(height: 8),
          const Text('Panel Members:'),
          const SizedBox(height: 4),
          const Text('• Professor Quilin Ke, UCL'),
          const Text('• Professor Ashish Gupta, RICSSBE, India'),
          const Text('• Dr Wayne Wan, Monash'),
          const Text('• Victoria Cook, Yarra Valley Water'),
        ],
      ),
    );
  }

  Widget buildLunchBreak() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.restaurant, color: Colors.brown, size: 24),
          const SizedBox(width: 12),
          const Text(
            '13:00 - 14:00 - Lunch Break',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSiteVisitSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Day 1 - Site Visit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4285F4),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Melbourne-based project with a decarbonization and net-zero focus (500 Bourke St)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Time: 15:00 - 18:30 pm',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Limited seats on a first-come first-served basis, Registration required**',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMasterclassTimeSlot(
      String time, String title, String speaker, Color timeColor) {
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: timeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
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
                if (speaker.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    speaker,
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
            buildTimeSlot('8:30 - 9:50', 'Registration', '', Colors.blue),
            buildTimeSlot(
                '8:50 - 9:00',
                'Welcome',
                'Professor Jenny George, Dean Melbourne Business School',
                Colors.purple),
            buildKeynoteSession(),
          ],
        ),
      ),
    );
  }

  Widget buildKeynoteSession() {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '9:00 - 9:45',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keynote Speech',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Accelerating Real Estate Capital & Dealmaking in an AI Era',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text('Venue: LT1\n'
              'Speaker: Jason F. Yong, Chief Investment Officer, CapitalxWise'),
        ],
      ),
    );
  }

  Widget buildAllSessions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 9:45 - 11:15 Sessions
        buildTimeSlotHeader('9:45 - 11:15'),

        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'PhD Colloquium I',
          venue: 'MURRA',
          chair: 'Chair: Kazuto Sumita',
          presentations: [
            'The neglected cost: Ecological consequences of urban expansion from a triple-coupling perspective - Weilong Kong (Discussant: Kazuto Sumita)',
            'Urban compactness and carbon emissions: A novel insight based on urban scaling law - Jinfang Pu (Discussant: Kazuto Sumita)',
            'Analysis of Policy Effectiveness for Curbing Real Estate Speculation in Korea – Seoul City Land Transaction Permit System - Kyung-hyun Park (Discussant: Jae Won Kang)',
            'Barriers to the implementation of passive retrofitting of residential buildings: A comparative analysis of operational-level stakeholders\' perceptions - Ayodele Adegoke (Discussant: Jae Won Kang)',
          ],
          color: Colors.purple,
        ),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'PhD Colloquium 2',
          venue: 'LT4',
          chair: 'Chair: Yang Shi',
          presentations: [
            'Exploring Risks in Overseas Real Estate Investment: Challenges and Strategies for Taiwanese Investors - Po-Wei Fu (Discussant: Yang Shi)',
            'Exploring the Application of TNFD in Real Estate Development: The Case of Swire Properties, Hong Kong - Ge-Ting Yan (Discussant: Yang Shi)',
            'The development of the REITs and RWA: Lessons from Taiwan - Wen-Jia Su (Discussant: Yang Shi)',
            'The motivational factors affecting housing development projects within communities on land with long-term leasehold rights: A case study of the Tap Pra Tan housing community in Bangkok, Thailand - Amaraporn Khaikham; Pornraht Pongprase (Discussant: Yang Shi)',
            'Urban Greenery and Real Estate Price - Thomas Chen (Discussant: Yang Shi)',
          ],
          color: Colors.green,
        ),
        const SizedBox(height: 16),
        buildCoffeeBreak('11:15 - 11:30 - Coffee Break'),
        const SizedBox(height: 16),

        // 11:30 - 13:00 Sessions
        buildTimeSlotHeader('11:30 - 13:00'),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'PhD Colloquium 3',
          venue: 'MURRA',
          chair: 'Chair: Janet Ge',
          presentations: [
            'Place-based policy and revitalization of resource-based cities - Policy evaluation based on the National Sustainable Development Plan for Resource-based Cities (2013-2020) - Xiaoqi Liu (Discussant: Godwin Kavaarpuo)',
            'Shanghai in Flux: Evaluating the Building Expansion Effects of River Crossings Using Satellite Imagery - Ze Wang (Discussant: Godwin Kavaarpuo)',
            'Factors influencing housing purchase decision among the younger generation: A review of the Malaysia housing market - Seok Ying Chua (Discussant: Janet Ge)',
            'Winners and Losers of Opportunity: Insights from a Low-Income Housing Lottery in the Philippines - Tomoki Nishiyama; Ze Wang (Discussant: Janet Ge)',
            'Strategic collaborative framework in urban agriculture initiatives between local authorities and management of strata housing toward sustainable city - Nurulanis Ahmad; Zarita Ahmad; Yasmin Mohd Adnan',
          ],
          color: Colors.purple,
        ),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'PhD Colloquium 4',
          venue: 'LT4',
          chair: 'Chair: Samuel Swanzy-Impraim',
          presentations: [
            'A study for factors for operating income and cap rates of JREITs in Tokyo - Kohei Tsujii',
            'A study of change in people\'s perception in Ho Chi Minh city - Sayoko Hattori',
            'Determinants of property value, cap rate, NOI in commercial properties owned by JREITs - Naoki Toyoyoshi',
            'Benefits and challenges of blockchain technology in real estate A literature review - Dengjin Wu',
            'Understanding Valuation Service Quality in a Developing Market - Uyanwaththe Gedara Geethika Nilanthi Kumari',
          ],
          color: Colors.green,
        ),
        const SizedBox(height: 16),

        // Lunch break
        buildCoffeeBreak('13:00 - 14:00 - Lunch'),
        const SizedBox(height: 16),

        // 14:00 - 15:30 Sessions
        buildTimeSlotHeader('14:00 - 15:30'),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'Session: Financial markets',
          venue: 'MURRA',
          chair: 'Chair: Ming-Chi Chen',
          presentations: [
            'Does Foreclosure have Spillover Effects on the Related Housing Market? - Shijun Liu, Weida Kuang',
            'The Concentrated Real Estate Lending and its Impacts on Bank Performance - Fang-Ni Chu, Ming-Chi Chen',
            'Housing Justice Improvement: Housing Tax Reform and Housing definancialization Taiwan experience - Ying-Hui Chiang',
            'The Impact of Selective Credit Controls on Taiwan\'s Housing Market: Evidence from Panel Data 2001–2024 - Chih Yuan Yang',
          ],
          color: Colors.purple,
        ),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'Session: Sustainability',
          venue: 'L1',
          chair: 'Chair: Saurabh Verma',
          presentations: [
            'Cross-Regional Patent Network and Green Technology Evolution:Pathways Based on the"Relatedness-Complexity"FrameworkJianping Gu, Yayu Xu',
            'Uncertainty Horizons: Investigating the Impact of Climate Policy on Housing Markets in 35 Major ChineseCities Jianing Wang',
            'From policy to progression: Mapping India\'s energy policy landscape for anet-zero built environment.Saurabh Verma',
            'Sea level rise, collateral constraints, and entrepreneurship Liuming Yang',
          ],
          color: Colors.purple,
        ),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'Session: Commercial real estate',
          venue: 'LT4',
          chair: 'Chair: Tien Foo Sing',
          presentations: [
            'Retail Vacancy and Property Value in Shrinking Cities: A Case Study of Small-Sized Cities in Korea - Jeongseob Kim',
            'Risk-Taking Behavior of Foreign Investors in Commercial Real Estate Markets - Tien Foo Sing',
            'Tariffs on the Move: Unpacking Their Impact on Asia Pacific Logistics Hubs - Benedict Lai, Sandy Padilla',
            'Determinants of Warehouse Rents in India - Prashant Das; Pritha Dev',
          ],
          color: Colors.green,
        ),
        const SizedBox(height: 16),
        buildCoffeeBreak('15:30 - 15:45 - Coffee Break'),
        const SizedBox(height: 16),

        // 15:45 - 17:15 Sessions
        buildTimeSlotHeader('15:45 - 17:15'),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'PhD Colloquium 5',
          venue: 'MURRA',
          chair: 'Chair: Desmond Tsang',
          presentations: [
            'Measuring the well-being of individuals living in social housing through capability approach - Farzaneh Janakipour (Discussant: Desmond Tsang)',
            'Developing A Framework to Mitigate Stigmatized Property Overhang in High-Rise Residential - Noor Farhana Akrisha Ishak, Zarita Ahmad (Discussant: Desmond Tsang)',
            'Formulating a stigmatized dimension of residential properties overhang model from the purchasers\' perspective in Selangor - Norulelin Huri, Zarita Ahmad (Discussant: Desmond Tsang)',
            'Time-varying Spillover Effects of House Prices: a Case Study of Metropolitan NSW - Dongkai Li, Janet Ge (Discussant: Wayne Wan)',
            'Dynamic Interactions Between Pre-sale and Existing Housing Markets - Chiu-Ming Shen (Discussant: Wayne Wan)',
            'Strategic Real Estate Investment Decision-Making Framework for Institutional Investors in Malaysia - Fatin Aziz',
          ],
          color: Colors.purple,
        ),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'Session: Real estate in Asia',
          venue: 'LT1',
          chair: 'Chair: Hyunmin Kim',
          presentations: [
            'When a Measure Becomes a Target: Local Governments\' strategic responses to Price Stability Target in Chinese Housing Market - Jiaxin Zheng, Rongjie Zhang, Jing Wu (Discussant: Godwin Kavaarpuo)',
            'Impact of Fertility Relaxation on the Housing Market Outcomes - Keyang Li, Yixun Tang, Qiuyi Wang (Discussant: Janet Ge)',
            'Competitive Investment in Human Capital: The Case of "Good School" Premium in Housing Prices - Jing Wu, Rongjie Zhang',
            'Household-level determinants of vacant housing: Evidence from a nationwide survey in Japan - Masatomo Suzuki, Norifumi Yukutake',
            'Analyzing the Impact of Fourth Industrial Revolution Technology on Real Estate Industry Productivity in South Korea - Soonmahn Park, Young-Hyuck Kim',
          ],
          color: Colors.green,
        ),
        const SizedBox(height: 16),
        buildNewFormatSession(
          title: 'Session: Sustainability',
          venue: 'LT4',
          chair: 'Chair: Ashish Gupta',
          presentations: [
            'Decoding LEED Platinum Certification: The critical Role of Onsite and Offsite Renewable Energy Adoption in Commercial Buildings - Akshay Bhardawaj, Saurabh Verma (Discussant: Ashish Gupta)',
            'Does Green Building Really Deliver? Unpacking Strategic Scoring Behaviors in China\'s Green Building Certification System - Jing Wu; Xinru Wu (Discussant: Ashish Gupta)',
            'Exploring the Determinants of Real Estate Developers\' Decisions in Pursuing Net Zero Buildings in Thailand - Satapat Kanchong; Pornraht Pongprase (Discussant: Ashish Gupta)',
            'Material Recycling and Reuse situation in Building Demolition - Bowen Jiang, Jing Wu, Rongjie Zhang',
            'Are Property Markets Prepared for Climate Change Adaptation? The Impacts of Flood Risk and Early Warning Systems on Property Values in South Korea - Gyojun Shin',
          ],
          color: Colors.green,
        ),
        const SizedBox(height: 16),

        // Evening events
        buildEventSection(),
      ],
    );
  }

  Widget buildTimeSlotHeader(String timeSlot) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF4285F4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          timeSlot,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildNewFormatSession({
    required String title,
    required String venue,
    required String chair,
    required List<String> presentations,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color == Colors.purple ? Colors.purple[50] : Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              color == Colors.purple ? Colors.purple[200]! : Colors.green[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Venue badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Venue - $venue',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),

          // Chair
          Text(
            chair,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),

          // Presentations
          ...presentations.map((presentation) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        presentation,
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget buildCoffeeBreak(String time) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.coffee, color: Colors.brown, size: 24),
          const SizedBox(width: 12),
          Text(
            time,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEventSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evening Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[700],
            ),
          ),
          const SizedBox(height: 16),

          // Site Visit
          buildEventItem(
            time: '17:15 - 19:00',
            title: 'Visit to MSDx',
            description:
                'An exhibition of students works at Melbourne School of Design, Glyn Davis Building',
            note: '(optional and self-guided)',
            icon: Icons.school,
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // Board Meeting 1
          buildEventItem(
            time: '17:00 - 18:00',
            title: 'AsRES Board Meeting 1',
            description: 'Board meeting for AsRES members',
            note: '(on invitation)',
            icon: Icons.meeting_room,
            color: Colors.orange,
          ),

          const SizedBox(height: 12),

          // Board Meeting 2
          buildEventItem(
            time: '18:00 - 19:00',
            title: 'AsRES Board Meeting 2',
            description: 'Board meeting for AsRES members',
            note: '(on invitation)',
            icon: Icons.meeting_room,
            color: Colors.orange,
          ),

          const SizedBox(height: 12),

          // Welcome Reception
          buildEventItem(
            time: '19:00 - 21:00',
            title: 'Welcome Reception',
            description:
                'University House, Law Building, University of Melbourne, Parkville Campus',
            note: '',
            icon: Icons.celebration,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget buildEventItem({
    required String time,
    required String title,
    required String description,
    required String note,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        time,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    if (note.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        note,
                        style: const TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeSlot(
      String time, String title, String speaker, Color timeColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: timeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
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
                if (speaker.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    speaker,
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
}
