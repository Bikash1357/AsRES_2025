import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Day3july11Screen extends StatelessWidget {
  const Day3july11Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Day 3 - July 11'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDayHeader('Day Three – 11th July 2025', 'Marriott Docklands'),
            const SizedBox(height: 24),

            // Morning Session (9:00 - 10:30)
            _buildTimeSlot(
              '9:00 – 10:30',
              [
                _buildVenueSession(
                  'Venue - Palladium',
                  'AsRES Women in Property Panel Discussion',
                  'Moderator: Professor Janet Ge, University of Technology Sydney',
                  [
                    'Professor Jua Cilliers, Associate Dean (Research) University of Technology, Sydney',
                    'Professor Quiin Ke, University College London',
                    'Hon. Professor Yasmin Binti Mohd Adnan, Universiti Malaya',
                    'Dr Jyoti Shukla, University of Melbourne'
                  ],
                  'Discussion Topics:\n• Professional development & career advancement\n• Networking & collaboration\n• Leadership & Representation\n• Global & social impact',
                  Colors.purple,
                ),
                _buildVenueSession(
                  'Venue - Palladium 1',
                  'Climate change and ESG',
                  'Chair: Tien Foo Sing',
                  [
                    'Assessing the Impact of Climate News Risk on Stock Market Returns - Zhi Min Zhang',
                    'ESG Strategies and Institutional Ownership: How Sustainability Influences Investor Decisions – Tien Foo Sing; Zhi Min Zhang',
                    'Greenwashing of ESG bonds - Tien Foo Sing',
                    'How Investors React to Climate Change? Evidence from US Real Estate Investment Trusts – Jeongseop Song',
                    'ESG Sentiment Index via BERT and ESG Performance: Evidence from Australian Listed Real Estate – Zheng Zheng'
                  ],
                  '',
                  Colors.green,
                ),
                _buildVenueSession(
                  'Venue - Dock',
                  'Climate change, Carbon emission and Net Zero Energy',
                  'Chair: Kang Mo Koo',
                  [
                    'Urban Climate Change and Urban Development: A Case Study of Tokyo –Naoto Mikawa; Mieko Fujisawa; Mizuki Kawabata',
                    'Impact of Carbon Emission Reduction Policies on Urban Sustainability: A Multi-Technology Sectoral DSGE Model Analysis – Jianping Gu; Yi Li',
                    'Achieving Net Zero Carbon in India\'s Building and Real Estate Sector: Status, Barriers, and Strategies – Ashish Gupta; Graeme Newell',
                    'Household Energy Saving after Removal of Overpass: Evidence from Seoul, Korea – Kang Mo Koo',
                    'Sustainability related features and their influence on rental value and tenant satisfaction: Implications for housing retrofit - Godwin Kavaarpuo; Samuel Swanzy-Imprain'
                  ],
                  '',
                  Colors.blue,
                ),
                _buildVenueSession(
                  'Venue - Observatory',
                  'Urbanization and land policies',
                  'Chair: Fan Zhang',
                  [
                    'Land Resource Misallocation and Enterprise New Quality Productive Forces: Evidence from China – Lin Zhou',
                    'The Effects and Mechanisms of Land Granting with Price Control: Evidence from China – Zixiao Chen',
                    'The Temporal and Spatial Spillover Effects of Housing Prices: Evidence from Mainland China – Dongkai Li',
                    'Environmental Regulating with Limited Attention: Evidence from Special Economic Zones of China – Fan Zhang',
                    'Operationalizing the 10-Minute City in Indonesia\'s Planned New Capital: Accessibility Analysis of Nusantara\'s Master Plan – Alyas Widita'
                  ],
                  '',
                  Colors.orange,
                ),
              ],
            ),

            // Coffee Break
            _buildBreak('10:30 – 11:00', 'Coffee Break'),

            // Late Morning Session (11:00 - 12:30)
            _buildTimeSlot(
              '11:00 – 12:30',
              [
                _buildVenueSession(
                  'Venue - Palladium',
                  'MDPI Journals Panel Discussion',
                  'The role of large-scale urban regeneration projects in shaping our cities – lessons from Melbourne Docklands\n\nModerator: Peter Holland - Director, Grant Advisory',
                  [
                    'Christian Grahame, Head of HOME Apartments',
                    'Brendon Rogers - Partner, Urbis',
                    'Rob Adams AM - Director, Adams Urban'
                  ],
                  '',
                  Colors.purple,
                ),
                _buildVenueSession(
                  'Venue - Palladium 1',
                  'Society and Cultural',
                  'Chair: Zarita Ahmad',
                  [
                    'You Had a Bad Day: Examining the Chinese Almanac Effect on the Housing Market – Desmond Tsang; Yiyi Zhao; Zeshen Ye',
                    'The Local Economic Effects of Recreational Marijuana Legalization: Evidence from the Restaurant Industry – Qilin Huang; Liuming Yang',
                    'Speech Sells? The Role of Agent Narratives in Property Rental – Keming Li; Desmond Tsang',
                    'More Than Meets the Eyes: The Role of Non-Verbal Communication in Real Estate Transactions – Zeshen Ye; Desmond Tsang',
                    'Enhancing ethical performance for a sustainable real estate agency practice in Malaysia - Zarita Ahmad'
                  ],
                  '',
                  Colors.green,
                ),
                _buildVenueSession(
                  'Venue- Dock',
                  'Disasters and relocation',
                  'Chair: Jyoti Shukla',
                  [
                    'Social Capital and Wellbeing: Recovery Process of Disaster-Affected Households in Japan – Norifumi Yukutake; Piyush Tiwari; Jyoti Shukla',
                    'Sustainable rehabilitation models for urban dilapidated housing: a social capital participation perspective – Hui Zeng; Song Wang',
                    'Environmental Information and Urban Migration: Evidence from China – Ying Fan; Zhiwei Liao'
                  ],
                  '',
                  Colors.blue,
                ),
                _buildVenueSession(
                  'Venue - Observatory',
                  'Agriculture and farmland',
                  'Chair: Kazuto Sumita',
                  [
                    'A Scattered Pattern of Economies of Scale in Farming in Taiwan - Tzu-Chin Lin',
                    'Relationship between Rent and Price of Farmland in Southern Taiwan - Tzu-Chin Lin',
                    'Evolving the governance mode and growth coalition of urban village renovation from the perspective of policy change: An empirical investigation from Guangzhou - Manman Xia'
                  ],
                  'Discussant: Kazuto Sumita',
                  Colors.orange,
                ),
              ],
            ),

            // Lunch Break
            _buildBreak('12:30 – 13:30', 'Lunch'),

            // Afternoon Session (13:30 - 15:00)
            _buildTimeSlot(
              '13:30 – 15:00',
              [
                _buildVenueSession(
                  'Venue - Palladium',
                  'Panel Discussion on Sustainable infrastructure',
                  'Moderator: Professor Jua Cilliers, University of Technology Sydney',
                  [
                    'Gail Hall - Australasian Green Infrastructure Network',
                    'Eric Fesselmeyer, Singapore Management University',
                    'Luli Castello, Australasian Green Infrastructure Network',
                    'Qiulin Ke, University College London'
                  ],
                  '',
                  Colors.purple,
                ),
                _buildVenueSession(
                  'Venue - Palladium 1',
                  'Real estate markets',
                  'Chair: Justine Wang',
                  [
                    'Drivers of the cross-section of real estate returns - Shaun Bond',
                    'Impact of commodity prices on real estate and equities prices in Australia - Justine Wang',
                    'Institutional voids and market expectation: land use rights, renewal uncertainty in China\'s commercial real estate - Rongxi Quan; Jing Wu; Rongjie Zhang',
                    'Land auctions and winner\'s curse: evidence from China - Ying Fan',
                    'Relative atypicality and local co-movements in real estate returns - Shaun Bond'
                  ],
                  '',
                  Colors.green,
                ),
                _buildVenueSession(
                  'Venue - Dock',
                  'Rental market',
                  'Chair: Ainoriza Mohd Aini',
                  [
                    'The Hidden Cost of Home Searching: How Increased Effort Raises Prices – Hefan Zheng; Jing Wu',
                    'New Winds Brings New Waves: Does the Long-term Rental Apartment Business Model Disrupt Rental Markets? – Yaopei Wang',
                    'The Dynamics of Shared Housing: Landlord Experiences in the Malaysian Private Rental Market – Ainoriza Mohd Aini',
                    'Tour detour: Intermediaries\' search diversion in rental markets – Ying Fan',
                    'Negotiating Co-living: A Study of Tenant Experiences and Conflict Resolution in Malaysia\'s Shared Housing Market - Zafirah Al Sadat Zyed'
                  ],
                  '',
                  Colors.blue,
                ),
                _buildVenueSession(
                  'Venue - Observatory',
                  'Housing institutions and Policy',
                  'Chair: Jinyoo Kim',
                  [
                    'Improvement of Information Transparency for the Actual Price Registration System in Taiwan - Fang-Ni Chu',
                    'Analysis of the types of jeonse fraud and institutional factors – Jinyoo Kim',
                    'Development of a Complaint Handling Guideline for the Management of Residential Strata Property in Malaysia – Yasmin Mohd Adnan; Zarita Ahmad',
                    'Housing Regulation and Household Consumption Risk – Yanhao Ding',
                    'Poverty, Health, and Inequality: Evidence from China\'s Targeted Poverty Alleviation Campaign – Jia Liu'
                  ],
                  '',
                  Colors.orange,
                ),
              ],
            ),

            // Coffee Break
            _buildBreak('15:00 – 15:30', 'Coffee Break'),

            // Late Afternoon Session (15:30 - 17:00)
            _buildTimeSlot(
              '15:30 – 17:00',
              [
                _buildVenueSession(
                  'Venue - Palladium',
                  'PhD Scholars Mentoring and Networking',
                  'Coordinated by Dr Godwin Kavaarpuo',
                  [],
                  '',
                  Colors.purple,
                ),
                _buildVenueSession(
                  'Venue - Palladium 1',
                  'House price',
                  'Chair: Yu Feng',
                  [
                    'Types of Urban Green Space and Housing Prices: Based on Evidence from Shenzhen, China – Qiulin Ke',
                    'The Impacts of Misunderstanding from COVID-19 Pandemic on the Housing Market: Evidence from Hospital Cluster Outbreak in Japan – Kazuto Sumita; Tsubasa Ito',
                    'How Does Housing Depreciation Affect Household Consumption: Evidence from China – Yu Feng',
                    'Has Covid-19 affected the implicit prices of office and housing attributes? Empirical evidence from Hong Kong - Ervi Liusman',
                    'Workplace flexibility: changes of office uses and the work arrangement in the city centre during pandemic - Kezia Hsu; Hoon Han'
                  ],
                  '',
                  Colors.green,
                ),
                _buildVenueSession(
                  'Venue - Dock',
                  'Sustainability',
                  'Chair: Wayne Wan',
                  [
                    'Tale of the Rotten-Tail Buildings: Information Contagion and Risk Spillover Effects of Mortgage Boycotts in China – Desmond Tsang',
                    'A Web-Based Guidance System to Conduct Contingent Valuation Method for Ecosystem Services - Weng Wai Choong',
                    'Unlocking air rights for affordable housing - Samuel Swanzy-Impraim, Godwin Kavaarpuo, Shuya Yang, Piyush Tiwari'
                  ],
                  '',
                  Colors.blue,
                ),
                _buildVenueSession(
                  'Venue - Observatory',
                  'House price and valuation',
                  'Chair: Tyler Yang',
                  [
                    'A Comparison of Hedonic and Repeat Sales Models: Evidence from China\'s Major Cities – Bowen Jiang; Jiahao Liu; Jing Wu',
                    'The Contradictory of Property Worth: Bridging the Gap Between An Agent\'s Market Opinion and A Valuer\'s Opinion Of Value - Jae Won Kang',
                    'Unlocking Sydney\'s Housing Potential: Assessing the Viability of Office-to-Residential Conversions – Beverley Lim',
                    'Property Flips and Repeat Sales House Price Index – Tyler Yang'
                  ],
                  '',
                  Colors.orange,
                ),
              ],
            ),

            // Gala Dinner
            _buildSpecialEvent(
              '18:30 – 20:30',
              'Gala Dinner',
              'Cargo Hall, South Wharf',
              Colors.deepPurple,
            ),

            const SizedBox(height: 20),
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

  Widget _buildTimeSlot(String time, List<Widget> venues) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                time,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...venues,
          ],
        ),
      ),
    );
  }

  Widget _buildVenueSession(
    String venue,
    String title,
    String moderator,
    List<String> items,
    String additional,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    venue,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: color.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (moderator.isNotEmpty) ...[
                  Text(
                    moderator,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                if (items.isNotEmpty) ...[
                  ...items.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.only(top: 8, right: 8),
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
                if (additional.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    additional,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                      fontSize: 13,
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

  Widget _buildBreak(String time, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.coffee,
            color: Colors.brown,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            '$time - $title',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialEvent(
      String time, String title, String location, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.celebration,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$time - $title',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
