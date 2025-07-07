import 'package:flutter/material.dart';

class Day2July10Screen extends StatelessWidget {
  const Day2July10Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Day 2 - July 10',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.green[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Day Two – 10th July 2025',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Marriott Docklands',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Schedule List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // 8:30-9:00 Registration
                _buildSessionCard(
                  time: '8:30 – 9:00',
                  venue: 'Palladium',
                  venueColor: Colors.purple,
                  title: 'Registration',
                  content: null,
                ),

                // 9:00-9:15 Welcome
                _buildSessionCard(
                  time: '9:00 – 9:15',
                  venue: 'Palladium',
                  venueColor: Colors.purple,
                  title: 'Welcome',
                  content:
                      'Professor Julie Willis, Dean Faculty of Architecture, Building and Planning, The University of Melbourne',
                ),

                // 9:15-10:00 Keynote 1
                _buildSessionCard(
                  time: '9:15 – 10:00',
                  venue: 'Palladium',
                  venueColor: Colors.purple,
                  title: 'Keynote Speech',
                  content:
                      'Indicators of Property Price Bubbles and the vital role of bank examination (Professor Naoyuki Yoshino, Professor Emeritus of Economics, Keio University, Special Professor, Tokyo Metropolitan University, Former Dean and CEO, Asian Development Bank Institute)',
                ),

                // 10:00-10:15 Keynote 2
                _buildSessionCard(
                  time: '10:00 – 10:15',
                  venue: 'Palladium',
                  venueColor: Colors.purple,
                  title: 'Keynote Speech',
                  content:
                      'Deputy Lord Mayor Roshena Campbell, City of Melbourne',
                ),

                // 10:15-11:00 Keynote 3
                _buildSessionCard(
                  time: '10:15 – 11:00',
                  venue: 'Palladium',
                  venueColor: Colors.purple,
                  title: 'Keynote Speech',
                  content:
                      'REITs 4.0: new frontiers of global securitisation in the real asset economy\n\nPeter Verwer',
                ),

                // 11:00-11:30 Coffee Break
                _buildCoffeeBreak('11:00 – 11:30'),

                // 11:30-12:30 Panel Discussion
                _buildSessionCard(
                  time: '11:30 – 12:30',
                  venue: 'Palladium',
                  venueColor: Colors.purple,
                  title:
                      'Panel Discussion: Emerging trends in property finance and investment',
                  content:
                      'Moderator: Jack Jiang, Director Wealth Pi Fund\nPresentation: Christina Jiang, Director Wealth Pi Fund\n\nPanellists:\n• Jeff Davies, Director, KordaMentha Real Estate\n• Wendy Fergie, CIO, Wealth Pi Fund\n• Ke Lu, Director, 16MC Development\n• Professor Robert Edelstein, Professor Emeritus, Maurice Mann Chair in Real Estate, Co-Chair, Fisher Center for Real Estate & Urban Economics, Haas School of Business, University of California\n\n'
                      'This session will:\nDiscuss emerging trends and innovations in real estate investment, development, and finance. Highlight the intersection between academic research and industry practice, including how research can inform strategic decision-making. Foster dialogue between academia and industry leaders, identifying opportunities for collaboration and knowledge exchange. Reflect on the role of technology, data, and policy in shaping future real estate markets, particularly in the Asia-Pacific context.',
                ),

                // 11:30-12:30 Transport and Housing Session
                _buildSessionCard(
                  time: '11:30 – 12:30',
                  venue: 'Dock',
                  venueColor: Colors.blue,
                  title: 'Session – Transport and Housing',
                  content:
                      'Chair: Janet Ge\n\n1. The Impact of the New Mass Rail Transit Line on the Return and Risk of Residential Real Estate – Yaopei Wang\n\n2. The Unintended Social Consequences of High-Speed Rail: Evidence from Crime in China - Desmond Tsang; Zhankun Chen\n\n3. The improvement of transportation infrastructure and the Sydney property market – Xin Janet Ge\n\n4. Mobility and Fertility: Evidence from High-Speed Rail in Taiwan - Pei-Syuan Lin; Tien Foo Sing',
                ),

                // 11:30-12:30 Data and Technology Session
                _buildSessionCard(
                  time: '11:30 – 12:30',
                  venue: 'Observatory',
                  venueColor: Colors.orange,
                  title: 'Session – Data and Technology',
                  content:
                      'Chair: Shuya Yang\n\n1. Are Data Centers Hate Facilities? - Focusing on South Korea\'s housing prices - Soonmahn Park\n\n2. Digital Marketing in the Property Sector: Navigating Opportunities and Challenges – Eunhye Beak; Jae Won Kang\n\n3. Identifying Urban Residential Pain Points Based on People\'s Daily Online Text – Ziyi Bian\n\n4. Determinants of office building rents in the cities of developing countries: A case study of India\'s National Capital Region (NCR) Saurabh Verma',
                ),

                // 12:30-13:30 Lunch
                _buildCoffeeBreak('12:30 – 13:30', title: 'Lunch'),

                // 13:30-15:00 Sessions
                // Housing Session
                _buildSessionCard(
                  time: '13:30 – 15:00',
                  venue: 'Palladium 1',
                  venueColor: Colors.green,
                  title: 'Session: Housing',
                  content:
                      'Chair: Tsur Somerville\n\n1. An Ecosystems approach to solving the affordable housing crisis: A case of Global Housing Technology Challenge India\nAlaknanda Menon\nDiscussant: Ying Fan\n\n2. Housing Affordability Program and Household Financial Market Participation: Evidence from China\nYanhao Ding\nDiscussant: Alaknanda Menon\n\n3. The economics of urban redevelopment: Price gradient, spatial structure, and spillover\nYing Fan\nDiscussant: Tsur Somerville\n\n4. The Effects of Temporary Housing Provision on Recovery of Well-being in Major Disaster\nNorifumi Yukutake, Jyoti Shukla, Piyush Tiwari\nDiscussant: Tsur Somerville\n\n5. Empty Homes, Vacancy Taxes, and Housing Affordability\nTsur Somerville\nDiscussant: Masatomo Suzuki',
                ),

                // Market Behaviour Session
                _buildSessionCard(
                  time: '13:30 – 15:00',
                  venue: 'Palladium 2',
                  venueColor: Colors.teal,
                  title: 'Session: Market Behaviour',
                  content:
                      'Chair: Timothy Riddiough\n\n1. Search Frictions, Investment Strategies, and Performance in Private Equity\nTimothy Riddiough\nDiscussant: Jiayu Zhang\n\n2. The Golden Cage: How Real Estate Corporate Financialization Traps Firms in Debt Risk\nDaizhong Tang; Jingyi Wang\nDiscussant: Dongho Kim\n\n3. The Regulatory Role of Local Governments in Urban Renewal Funds in China: A Game Theory Approach\nJiayu Zhang\nDiscussant: Daizhong Tang\n\n4. Hidden Costs of New Clean Technology: Risk Perception and Housing Price Adjustments\nDongho Kim\nDiscussant: Timothy Riddiough\n\n5. A Note on the Pricing System for Real Estate and Financial Markets\nHiroshi Ishijima',
                ),

                // Policy Session
                _buildSessionCard(
                  time: '13:30 – 15:00',
                  venue: 'Palladium 3',
                  venueColor: Colors.pink,
                  title: 'Session: Policy',
                  content:
                      'Chair: Jyoti Shukla\n\n1. The impact of facilities on US property values\nRita Yi Man Li\nDiscussant: Jyoti Shukla\n\n2. Evolution of China\'s Land Reclamation Policies and Strategies for Sustainable Governance\nDahai Liu\nDiscussant: Hainan Sheng\n\n3. On well-being of households in Japan and post-disasters reinstatement\nJyoti Shukla, Norifumi Yukutake, Piyush Tiwari\nDiscussant: Rita Yi Man Li\n\n4. Winners and Losers in Corrupt Markets: The Impact of Political Misconduct on Commercial Real Estate\nHainan Sheng\nDiscussant: Jyoti Shukla',
                ),

                // Planning and Regulation Session
                _buildSessionCard(
                  time: '13:30 – 15:00',
                  venue: 'Dock',
                  venueColor: Colors.blue,
                  title: 'Session: Planning and Regulation',
                  content:
                      'Chair: Ameeta Jain\n\n1. Intra-household Bargaining and Fertility Decision-making: Evidence from Homeownership Structure and Housing Price Shocks in China – Boyuan Huang; Rongjie Zhang; Lin; Jing Wu\nDiscussant: Shuya Yang\n\n2. Regulatory controls, housing supply and the pandemic: evidence from Australia\nShuya Yang\n\n3. Research on area management strategies in emerging Asian city - Targeting a commercial facility event in Binh Duong, Vietnam\nNaoya Sato\nDiscussant: Boyuan Huang\n\n4. The Housing Burden of Entrepreneurial Cities: Evidence from China\'s Technology Hub Hangzhou\nShuai Shi\nDiscussant: Ameeta Jain\n\n5. Ethnic Diversity and Housing Market Resilience after Natural Disasters: Evidence from Australia\nAmeeta Jain; Qiang Li\nDiscussant: Shuai Shi',
                ),

                // Market Behaviour Session 2
                _buildSessionCard(
                  time: '13:30 – 15:00',
                  venue: 'Observatory',
                  venueColor: Colors.orange,
                  title: 'Session: Market Behaviour',
                  content:
                      'Chair: Edward Chi Ho Tang\n\n1. Nudging approach for fostering sustainable practices among building users\nWeng Wai Choong; Sheau Ting Low\nDiscussant: Edward Tang\n\n2. The Impact of the Illusory Truth Effect on Taiwan\'s Real Estate Market: Repeated Exposure to Fake News, Fact-Checking, and Motivated Reasoning\nJing-Yi Chen\nDiscussant: Weng Wai Choong\n\n3. Buzz as the Signal? Exploring Real Estate Market Trends through Social Sentiment and ChatGPT-Powered Semantic Analysis\nNanyu Chu\nDiscussant: Jing-Yi Chen\n\n4. Good things come in pairs? Block Trade in Housing Market\nEdward Chi Ho Tang\nDiscussant: Nanyu Chu\n\n5. Office Space Management Post COVID-19 Pandemic in Kuala Lumpur\nMohd Fitry bin Hassim\nDiscussant: Edward Chi Ho Tang',
                ),

                // 15:00-15:30 Coffee Break
                _buildCoffeeBreak('15:00 – 15:30'),

                // 15:30-17:00 Sessions
                // Housing Session 2
                _buildSessionCard(
                  time: '15:30 – 17:00',
                  venue: 'Palladium 1',
                  venueColor: Colors.green,
                  title: 'Session: Housing',
                  content:
                      'Chair: Bor-Ming Hsieh\n\n1. Housing Price Surge in the Hsinchu Science Park Area: A Hi-Tech Boom or Speculative Flipping?\nBor-Ming Hsieh\nDiscussant: William K S Cheung\n\n2. When Minds Lag Behind Markets: Policy Nudging and Expectation Formation in Housing Markets\nWilliam K S Cheung\nDiscussant: Ming Shann Tsai\n\n3. The economic implications of map distortion: evidence from the housing market\nCheng Tang\nDiscussant: Bor-Ming Hsieh\n\n4. What Matters Most? A Cross-Generation Study on Perceived Importance of Retirement Home Features and Services\nLow Sheau Ting\nDiscussant: Cheng Tang\n\n5. Analyzing Asymmetric Price Adjustments in Housing and Rental Markets with Threshold Models and Housing Market Attentions\nMing Shann Tsai; Shu Ling Chiang\nDiscussant: Bor-Ming Hsieh',
                ),

                // Sustainability Session
                _buildSessionCard(
                  time: '15:30 – 17:00',
                  venue: 'Palladium 2',
                  venueColor: Colors.teal,
                  title: 'Session: Sustainability',
                  content:
                      'Chair: Raghu Tirumala\n\n1. Opportunities and challenges in transitioning to renewable energy in commercial buildings in India\nRaghu Tirumala; Ameeta Jain, Saurabh Verma\nDiscussant: Seonghun Min\n\n2. Public Pool Usage as Adaptation Against Urban Heat in New York City\nEric Fesselmeyer\nDiscussant: Raghu Tirumala\n\n3. The Impact of Urban Land Intensive Utilization on Carbon Emissions: Land Use Differentiation and Spatiotemporal Heterogeneity\nChai Duo\nDiscussant: Eric Fesselmeyer\n\n4. Uncovering Green Premiums Over Time: A Dynamic Analysis of Certification Effects in Seoul\'s Housing Market\nSeonghun Min\nDiscussant: Chai Duo',
                ),

                // Housing Finance Session
                _buildSessionCard(
                  time: '15:30 – 17:00',
                  venue: 'Palladium 3',
                  venueColor: Colors.pink,
                  title: 'Session: Housing Finance',
                  content:
                      'Chair: Weida Kuang\n\n1. A Study on the Causality of Reverse Mortgage, GDP, and Housing Price using Bootstrap Fourier Granger Causality in Quantiles\nMing-Che Wu\nDiscussant: Ling Zhang\n\n2. Decrease in Mortgage Payments, Where Does the Money Go? — An Empirical Analysis of Household Consumption Distribution and Saving Behavior\nPei-Syuan Lin\nDiscussant: Weida Kuang\n\n3. Exploring the Threshold Effects in Foreclosure Recovery Rate and Foreclosure Lag Distributions\nShu Ling Chiang; Ming Shann Tsai\nDiscussant: Pei-Syuan Lin\n\n4. Housing price expectation and default risk of real estate firms\nWeida Kuang, Yongman WuDuo\nDiscussant: Ming-Che Wu\n\n5. The Development Differences of Districts and the Boundary Effect of Housing Prices in Hangzhou, China\nLing Zhang\nDiscussant: Weida Kuang',
                ),

                // Housing Session 3
                _buildSessionCard(
                  time: '15:30 – 17:00',
                  venue: 'Dock',
                  venueColor: Colors.blue,
                  title: 'Session: Housing',
                  content:
                      'Chair: Shotaro Watanabe\n\n1. Asset Accumulation in Low-Income Households: Divergent Effects of Housing Assistance Schemes in South Korea\nJi-Na Kim\nDiscussant: Rita Yi Man Li\n\n2. Willingness to Pay for Senior Housing: Evidence from Two Coastal Chinese Cities\nRita Yi Man Li\nDiscussant: Jyoti Shukla\n\n3. Examining housing satisfaction through the lens of \'capability approach\': Case of Japan\nJyoti Shukla, Piyush Tiwari, Norifumi Yukutake\nDiscussant: Shotaro Watanabe\n\n4. Parental Default Strategies and Their Financial Legacy: Asset Accumulation and Debt Behaviour in the Next Generation\nShotaro Watanabe\nDiscussant: Yilan Luo\n\n5. Electricity Supply Uncertainty in the City: Perceived Risks, Housing Market Reactions, and Migration Patterns\nYilan Luo\nDiscussant: Shotaro Watanabe',
                ),

                // Affordability Session
                _buildSessionCard(
                  time: '15:30 – 17:00',
                  venue: 'Observatory',
                  venueColor: Colors.orange,
                  title: 'Session: Affordability',
                  content:
                      'Chair: Jae Won Kang\n\n1. Evaluating the Impact of Federal Government Housing Policies on Affordability and Market Dynamics in Australia – Jae Won Kang\nDiscussant: Hyung Min Kim\n\n2. The effect of Affordable housing on the mobility of Entrepreneurial Talent – Jianshuang Fan\nDiscussant: Minghng Yu\n\n3. Policy-induced Housing Market Segmentation and Young Homebuyers\' Trade-offs: Evidence from Singapore\'s Presale Public Housing Reform – Minghang Yu\nJae Won Kang\n\n4. Transitioning from Informal to Formal Settlements: A Case Study of Manseok-dong, Incheon – Hee Jin Yang\nDiscussant: Jae Won Kang\n\n5. The Irony of Formalisation of Informal Settlements: A Case Study of 104 Village in Seoul, South Korea – Hyung Min Kim\nDiscussant: Hee Jin Yang',
                ),

                // 19:00-21:00 Conference Dinner
                _buildSessionCard(
                  time: '19:00 – 21:00',
                  venue: 'Marriott Docklands',
                  venueColor: Colors.red,
                  title: 'Conference Dinner',
                  content: null,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard({
    required String time,
    required String venue,
    required Color venueColor,
    required String title,
    String? content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: venueColor
            .withOpacity(0.05), // Light background color based on venue color
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: venueColor.withOpacity(0.2)), // Light border
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Venue badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: venueColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Venue - $venue',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          // Content
          if (content != null) ...[
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCoffeeBreak(String time, {String? title}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.coffee,
            color: Colors.brown,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            '$time - ${title ?? 'Coffee Break'}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
