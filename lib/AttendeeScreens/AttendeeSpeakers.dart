import 'package:flutter/material.dart';

class SpeakersPage extends StatelessWidget {
  const SpeakersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSpeakerCard(
                'Jason F. Yong',
                'Chief Investment Officer',
                'CapitalxWise',
                'Keynote speaker on "Accelerating Real Estate Capital & Dealmaking in an AI Era"',
              ),
              const SizedBox(height: 16),
              buildSpeakerCard(
                'Jenny George',
                'Dean',
                'Melbourne Business School',
                'Welcome address and conference opening',
              ),
              const SizedBox(height: 16),
              buildSpeakerCard(
                'Julie Willis',
                'Dean ABP',
                'Architecture, Building and Planning',
                'Day Two welcome address',
              ),
              const SizedBox(height: 16),
              buildSpeakerCard(
                'Naoyuki Yoshino',
                'Advisor',
                'FSA Japan',
                'Keynote speaker on financial services and real estate',
              ),
              const SizedBox(height: 16),
              buildSpeakerCard(
                'Peter Verwer',
                'Industry Expert',
                'Real Estate Securitisation',
                'Keynote on "REITs 4.0: new frontiers of global securitisation in the real asset economy"',
              ),
              const SizedBox(height: 16),
              buildSpeakerCard(
                'Christina Jiang',
                'Director',
                'Wealth Pi',
                'Panel moderator for "Emerging trends in property finance and investment"',
              ),
              const SizedBox(height: 16),
              buildSpeakerCard(
                'Jua Cilliers',
                'Academic',
                'University of Technology Sydney (UTS)',
                'Panel moderator for "Sustainable infrastructure" discussion',
              ),
              const SizedBox(height: 16),
              buildSpeakerCard(
                'Peter Holland',
                'Industry Expert',
                'Real Estate Development',
                'Panel moderator for "Docklands regeneration" discussion',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSpeakerCard(
      String name, String title, String company, String description) {
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF4285F4),
            child: Text(
              name.split(' ').map((n) => n[0]).join(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$title at $company',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4285F4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
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
