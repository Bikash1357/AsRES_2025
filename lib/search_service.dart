import 'package:flutter/material.dart';

// Enhanced SearchResult model with better categorization
class SearchResult {
  final String title;
  final String description;
  final String pageName;
  final String route;
  final IconData? icon;
  final Map<String, dynamic>? additionalData;
  final SearchCategory category;
  final int priority;
  final String? content; // Full content for better searching
  final List<String>? searchableFields; // Additional searchable fields

  SearchResult({
    required this.title,
    required this.description,
    required this.pageName,
    required this.route,
    this.icon,
    this.additionalData,
    required this.category,
    this.priority = 0,
    this.content,
    this.searchableFields,
  });
}

// Search categories for better organization
enum SearchCategory {
  schedule,
  information,
  networking,
  location,
  updates,
  speakers,
  sessions,
  food,
  accommodation,
  transportation,
  awards,
  registration,
}

// Enhanced SearchService with comprehensive content
class SearchService {
  static List<SearchResult> _searchData = [];
  static Map<String, List<String>> _searchIndex = {};

  // Initialize search data with comprehensive content from all pages
  static void initializeSearchData() {
    _searchData = [
      // Day 1 - July 9, 2025 Schedule
      SearchResult(
        title: "Day 1 Schedule - July 9, 2025",
        description:
            "Opening day with registration, keynote speakers, and welcome ceremony",
        pageName: "Day1July9Screen",
        route: "/day1july9",
        icon: Icons.calendar_today,
        category: SearchCategory.schedule,
        priority: 10,
        content: """
        Day 1 - July 9, 2025
        8:00 AM - Registration & Welcome Coffee
        9:00 AM - Opening Ceremony
        9:30 AM - Keynote Speech: Future of Real Estate
        10:30 AM - Coffee Break
        11:00 AM - Panel Discussion: Market Trends
        12:30 PM - Lunch Break
        2:00 PM - Research Paper Presentations
        3:30 PM - Networking Session
        4:30 PM - Workshop: Digital Real Estate
        6:00 PM - Welcome Reception
        """,
        searchableFields: [
          "opening day",
          "registration",
          "keynote",
          "welcome",
          "coffee",
          "ceremony",
          "panel discussion",
          "market trends",
          "research papers",
          "networking",
          "workshop",
          "digital real estate",
          "reception",
          "future of real estate"
        ],
      ),

      // Day 2 - July 10, 2025 Schedule
      SearchResult(
        title: "Day 2 Schedule - July 10, 2025",
        description: "Technical sessions, workshops, and poster presentations",
        pageName: "Day2July10Screen",
        route: "/day2july10",
        icon: Icons.calendar_today,
        category: SearchCategory.schedule,
        priority: 10,
        content: """
        Day 2 - July 10, 2025
        8:30 AM - Morning Coffee
        9:00 AM - Technical Session A: PropTech Innovations
        10:30 AM - Coffee Break
        11:00 AM - Technical Session B: Sustainable Development
        12:30 PM - Lunch & Poster Session
        2:00 PM - Workshop: AI in Real Estate
        3:30 PM - Panel: ESG in Real Estate
        4:30 PM - Breakout Sessions
        6:00 PM - Industry Mixer
        """,
        searchableFields: [
          "technical sessions",
          "proptech",
          "innovations",
          "sustainable development",
          "poster session",
          "AI",
          "artificial intelligence",
          "ESG",
          "environmental",
          "breakout sessions",
          "industry mixer",
          "workshops"
        ],
      ),

      // Day 3 - July 11, 2025 Schedule
      SearchResult(
        title: "Day 3 Schedule - July 11, 2025",
        description: "Final presentations, awards ceremony, and closing",
        pageName: "Day3July11Screen",
        route: "/day3july11",
        icon: Icons.calendar_today,
        category: SearchCategory.schedule,
        priority: 10,
        content: """
        Day 3 - July 11, 2025
        8:30 AM - Morning Coffee
        9:00 AM - Final Paper Presentations
        10:30 AM - Coffee Break
        11:00 AM - Best Paper Competition
        12:30 PM - Lunch
        2:00 PM - Awards Ceremony
        3:00 PM - Closing Keynote
        4:00 PM - Closing Remarks
        4:30 PM - Farewell Reception
        """,
        searchableFields: [
          "final presentations",
          "best paper",
          "competition",
          "awards ceremony",
          "closing keynote",
          "closing remarks",
          "farewell reception",
          "last day"
        ],
      ),

      // About AsRES Page Content
      SearchResult(
        title: "About AsRES Conference",
        description:
            "Learn about the Asian Real Estate Society and conference objectives",
        pageName: "AboutAsRESPage",
        route: "/about",
        icon: Icons.info,
        category: SearchCategory.information,
        priority: 8,
        content: """
        About Asian Real Estate Society (AsRES)
        
        The Asian Real Estate Society is a premier organization dedicated to advancing 
        real estate research, education, and practice across Asia. Our mission is to 
        foster collaboration among academics, industry professionals, and policymakers.
        
        Conference Objectives:
        • Promote cutting-edge research in real estate
        • Facilitate knowledge sharing and networking
        • Bridge academic research and industry practice
        • Advance sustainable real estate development
        • Foster innovation in property technology
        
        Code of Conduct:
        • Maintain professional behavior
        • Respect diverse perspectives
        • Encourage inclusive participation
        • Uphold academic integrity
        
        Conference Theme: "Sustainable Real Estate in the Digital Age"
        """,
        searchableFields: [
          "asian real estate society",
          "mission",
          "objectives",
          "research",
          "education",
          "academics",
          "industry professionals",
          "policymakers",
          "knowledge sharing",
          "sustainable development",
          "property technology",
          "code of conduct",
          "digital age",
          "innovation",
          "collaboration"
        ],
      ),

      // Event Connect Dashboard
      SearchResult(
        title: "Event Connect - Networking Hub",
        description:
            "Connect with researchers, professionals, and build relationships",
        pageName: "EventConnectDashboard",
        route: "/eventconnect",
        icon: Icons.people,
        category: SearchCategory.networking,
        priority: 8,
        content: """
        Event Connect - Networking Hub
        
        Connect with fellow attendees, researchers, and industry professionals:
        
        Features:
        • Attendee Directory
        • Messaging System
        • Meeting Scheduler
        • Interest-based Matching
        • Business Card Exchange
        • LinkedIn Integration
        
        Networking Opportunities:
        • Welcome Reception (July 9)
        • Coffee Breaks (All days)
        • Lunch Networking (All days)
        • Industry Mixer (July 10)
        • Farewell Reception (July 11)
        
        Professional Groups:
        • Academic Researchers
        • Industry Practitioners
        • Policy Makers
        • Students
        • International Delegates
        
        Tips for Networking:
        • Update your profile
        • Set your interests
        • Schedule meetings
        • Join group discussions
        """,
        searchableFields: [
          "networking",
          "attendee directory",
          "messaging",
          "meeting scheduler",
          "business cards",
          "linkedin",
          "welcome reception",
          "coffee breaks",
          "industry mixer",
          "researchers",
          "practitioners",
          "policy makers",
          "students",
          "international delegates",
          "profile",
          "discussions"
        ],
      ),

      // Location Page
      SearchResult(
        title: "Conference Venue & Location",
        description: "Venue information, maps, directions, and facilities",
        pageName: "LocationPage",
        route: "/location",
        icon: Icons.location_on,
        category: SearchCategory.location,
        priority: 8,
        content: """
        Conference Venue & Location
        
        Venue: Grand Convention Center
        Address: 123 Conference Street, Business District, Singapore
        
        Venue Facilities:
        • Main Auditorium (500 capacity)
        • 5 Breakout Rooms (50-100 capacity each)
        • Exhibition Hall
        • Networking Lounge
        • Business Center
        • Wi-Fi Throughout
        • Audio-Visual Equipment
        • Accessibility Features
        
        Parking:
        • On-site parking available
        • Valet parking service
        • EV charging stations
        
        Transportation:
        • MRT: City Hall Station (5 min walk)
        • Bus: Routes 12, 34, 56
        • Taxi/Grab readily available
        • Airport: 30 minutes by car
        
        Nearby Amenities:
        • Hotels within walking distance
        • Restaurants and cafes
        • Shopping centers
        • ATMs and banks
        
        Emergency Contacts:
        • Venue Security: +65 1234 5678
        • Medical Services: +65 8765 4321
        """,
        searchableFields: [
          "grand convention center",
          "venue",
          "address",
          "singapore",
          "auditorium",
          "breakout rooms",
          "exhibition hall",
          "networking lounge",
          "business center",
          "wifi",
          "audio visual",
          "accessibility",
          "parking",
          "valet",
          "ev charging",
          "MRT",
          "city hall station",
          "bus routes",
          "taxi",
          "grab",
          "airport",
          "hotels",
          "restaurants",
          "cafes",
          "shopping",
          "ATM",
          "emergency"
        ],
      ),

      // Recent Updates Page
      SearchResult(
        title: "Latest Conference Updates",
        description:
            "Recent announcements, schedule changes, and notifications",
        pageName: "RecentUpdatePage",
        route: "/updates",
        icon: Icons.update,
        category: SearchCategory.updates,
        priority: 9,
        content: """
        Latest Conference Updates
        
        July 8, 2025 - Final Preparations
        • Registration desk opens at 8:00 AM
        • Welcome packages ready for pickup
        • Mobile app now available for download
        
        July 7, 2025 - Speaker Update
        • Keynote speaker confirmed: Dr. Sarah Johnson
        • New workshop added: "Blockchain in Real Estate"
        • Panel discussion updated with new expert
        
        July 6, 2025 - Venue Information
        • Parking instructions distributed
        • Shuttle service from hotels confirmed
        • Catering menu finalized
        
        July 5, 2025 - Program Changes
        • Technical session timing adjusted
        • Poster session location changed to Hall B
        • Networking event extended by 30 minutes
        
        Important Reminders:
        • Bring photo ID for registration
        • Download conference app
        • Check dietary requirements
        • Prepare business cards
        • Review code of conduct
        """,
        searchableFields: [
          "updates",
          "announcements",
          "registration desk",
          "welcome packages",
          "mobile app",
          "keynote speaker",
          "dr sarah johnson",
          "blockchain",
          "workshop",
          "panel discussion",
          "parking instructions",
          "shuttle service",
          "catering",
          "program changes",
          "technical session",
          "poster session",
          "hall b",
          "networking event",
          "photo id",
          "dietary requirements",
          "business cards",
          "code of conduct"
        ],
      ),

      // Complete Schedule Page
      SearchResult(
        title: "Complete Conference Schedule",
        description: "Full 3-day schedule with all sessions and activities",
        pageName: "SchedulePage",
        route: "/schedule",
        icon: Icons.schedule,
        category: SearchCategory.schedule,
        priority: 10,
        content: """
        Complete Conference Schedule - AsRES 2025
        
        DAY 1 - JULY 9, 2025
        8:00 AM - Registration & Welcome Coffee
        9:00 AM - Opening Ceremony
        9:30 AM - Keynote: Future of Real Estate
        10:30 AM - Coffee Break
        11:00 AM - Panel: Market Trends
        12:30 PM - Lunch Break
        2:00 PM - Research Papers Session 1
        3:30 PM - Networking Break
        4:30 PM - Workshop: Digital Real Estate
        6:00 PM - Welcome Reception
        
        DAY 2 - JULY 10, 2025
        8:30 AM - Morning Coffee
        9:00 AM - Technical Session A: PropTech
        10:30 AM - Coffee Break
        11:00 AM - Technical Session B: Sustainability
        12:30 PM - Lunch & Poster Session
        2:00 PM - Workshop: AI in Real Estate
        3:30 PM - Panel: ESG in Real Estate
        4:30 PM - Breakout Sessions
        6:00 PM - Industry Mixer
        
        DAY 3 - JULY 11, 2025
        8:30 AM - Morning Coffee
        9:00 AM - Final Presentations
        10:30 AM - Coffee Break
        11:00 AM - Best Paper Competition
        12:30 PM - Lunch
        2:00 PM - Awards Ceremony
        3:00 PM - Closing Keynote
        4:00 PM - Closing Remarks
        4:30 PM - Farewell Reception
        """,
        searchableFields: [
          "complete schedule",
          "3-day",
          "timetable",
          "sessions",
          "activities",
          "all events",
          "timing",
          "full program"
        ],
      ),

      // Additional detailed search results for specific sessions
      SearchResult(
        title: "Registration & Welcome Coffee",
        description: "Conference registration and welcome coffee on Day 1",
        pageName: "Day1July9Screen",
        route: "/day1july9",
        icon: Icons.how_to_reg,
        category: SearchCategory.registration,
        priority: 7,
        content:
            "Registration starts at 8:00 AM on July 9. Welcome coffee served during registration.",
        searchableFields: [
          "registration",
          "welcome coffee",
          "8:00 AM",
          "check-in"
        ],
      ),

      SearchResult(
        title: "Awards Ceremony",
        description: "Recognition of outstanding research and contributions",
        pageName: "Day3July11Screen",
        route: "/day3july11",
        icon: Icons.emoji_events,
        category: SearchCategory.awards,
        priority: 8,
        content:
            "Awards ceremony on Day 3 at 2:00 PM. Recognizing best papers, outstanding contributions, and research excellence.",
        searchableFields: [
          "awards",
          "ceremony",
          "best paper",
          "recognition",
          "excellence"
        ],
      ),

      SearchResult(
        title: "Catering & Dining",
        description: "Meal information and dietary accommodations",
        pageName: "LocationPage",
        route: "/location",
        icon: Icons.restaurant,
        category: SearchCategory.food,
        priority: 6,
        content:
            "All meals provided during conference. Vegetarian, vegan, and halal options available. Special dietary requirements accommodated.",
        searchableFields: [
          "catering",
          "meals",
          "lunch",
          "dinner",
          "vegetarian",
          "vegan",
          "halal",
          "dietary"
        ],
      ),

      SearchResult(
        title: "Accommodation Information",
        description: "Hotel recommendations and booking information",
        pageName: "LocationPage",
        route: "/location",
        icon: Icons.hotel,
        category: SearchCategory.accommodation,
        priority: 6,
        content:
            "Partner hotels offer discounted rates. Shuttle service available from major hotels. Booking codes provided in registration email.",
        searchableFields: [
          "accommodation",
          "hotels",
          "booking",
          "shuttle",
          "discounts",
          "partner hotels"
        ],
      ),

      SearchResult(
        title: "Transportation & Parking",
        description: "Getting to the venue and parking information",
        pageName: "LocationPage",
        route: "/location",
        icon: Icons.directions_car,
        category: SearchCategory.transportation,
        priority: 6,
        content:
            "Multiple transport options available. Free parking for registered attendees. Valet service available. Public transport connections.",
        searchableFields: [
          "transportation",
          "parking",
          "free parking",
          "valet",
          "public transport",
          "directions"
        ],
      ),
    ];

    _buildSearchIndex();
  }

  // Build enhanced search index
  static void _buildSearchIndex() {
    _searchIndex.clear();
    for (int i = 0; i < _searchData.length; i++) {
      final result = _searchData[i];
      final words = <String>[
        ...result.title.toLowerCase().split(' '),
        ...result.description.toLowerCase().split(' '),
        ...result.pageName.toLowerCase().split(' '),
        if (result.content != null) ...result.content!.toLowerCase().split(' '),
        if (result.searchableFields != null) ...result.searchableFields!,
        if (result.additionalData != null &&
            result.additionalData!['keywords'] != null)
          ...List<String>.from(result.additionalData!['keywords']),
      ];

      for (final word in words) {
        final cleanWord = word.replaceAll(RegExp(r'[^\w]'), '');
        if (cleanWord.length > 2) {
          _searchIndex
              .putIfAbsent(cleanWord, () => <String>[])
              .add(i.toString());
        }
      }
    }
  }

  static List<SearchResult> search(String query) {
    if (query.isEmpty) return <SearchResult>[];

    final lowerQuery = query.toLowerCase();
    final queryWords =
        lowerQuery.split(' ').where((word) => word.length > 2).toList();

    Map<int, double> resultScores = <int, double>{};

    for (int i = 0; i < _searchData.length; i++) {
      final result = _searchData[i];
      double score = 0;

      // Exact phrase match (highest priority)
      if (result.title.toLowerCase().contains(lowerQuery)) score += 15;
      if (result.description.toLowerCase().contains(lowerQuery)) score += 10;
      if (result.content?.toLowerCase().contains(lowerQuery) ?? false)
        score += 8;

      // Searchable fields match
      if (result.searchableFields != null) {
        for (final field in result.searchableFields!) {
          if (field.toLowerCase().contains(lowerQuery)) score += 12;
        }
      }

      // Individual word matches
      for (final word in queryWords) {
        if (result.title.toLowerCase().contains(word)) score += 5;
        if (result.description.toLowerCase().contains(word)) score += 3;
        if (result.content?.toLowerCase().contains(word) ?? false) score += 2;

        if (result.searchableFields != null) {
          for (final field in result.searchableFields!) {
            if (field.toLowerCase().contains(word)) score += 4;
          }
        }
      }

      // Category bonus
      score += result.priority;

      // Time-based bonus (recent updates get higher priority)
      if (result.category == SearchCategory.updates) score += 5;

      if (score > 0) {
        resultScores[i] = score;
      }
    }

    final sortedIndices = resultScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedIndices.map((entry) => _searchData[entry.key]).toList();
  }

  static List<String> getSearchSuggestions(String query) {
    if (query.isEmpty) return <String>[];

    final suggestions = <String>[];
    final lowerQuery = query.toLowerCase();

    // Add exact matches first
    for (final result in _searchData) {
      if (result.title.toLowerCase().contains(lowerQuery) &&
          !suggestions.contains(result.title)) {
        suggestions.add(result.title);
      }
    }

    // Add searchable field matches
    for (final result in _searchData) {
      if (result.searchableFields != null) {
        for (final field in result.searchableFields!) {
          if (field.toLowerCase().contains(lowerQuery) &&
              !suggestions.contains(field)) {
            suggestions.add(field);
          }
        }
      }
      if (suggestions.length >= 8) break;
    }

    return suggestions.take(5).toList();
  }

  // Get results by category
  static List<SearchResult> getResultsByCategory(SearchCategory category) {
    return _searchData.where((result) => result.category == category).toList();
  }

  // Get popular searches
  static List<String> getPopularSearches() {
    return [
      "Day 1 schedule",
      "Awards ceremony",
      "Networking events",
      "Venue location",
      "Registration",
      "Speakers",
      "Workshops",
      "Parking",
    ];
  }
}

class HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle? style;
  final TextStyle? highlightStyle;

  const HighlightText({
    Key? key,
    required this.text,
    required this.highlight,
    this.style,
    this.highlightStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (highlight.isEmpty) {
      return Text(text, style: style);
    }

    final spans = <TextSpan>[];
    final pattern = RegExp(RegExp.escape(highlight), caseSensitive: false);
    final matches = pattern.allMatches(text);

    int start = 0;
    for (final match in matches) {
      if (match.start > start) {
        spans.add(
            TextSpan(text: text.substring(start, match.start), style: style));
      }
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: highlightStyle ??
            const TextStyle(
              backgroundColor: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
      ));
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: style));
    }

    return RichText(text: TextSpan(children: spans));
  }
}

// Enhanced Search Screen
class GlobalSearchScreen extends StatefulWidget {
  @override
  _GlobalSearchScreenState createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  List<String> _searchSuggestions = [];
  bool _isLoading = false;
  bool _showSuggestions = false;
  String _currentQuery = "";

  @override
  void initState() {
    super.initState();
    SearchService.initializeSearchData();
  }

  void _performSearch(String query) {
    setState(() {
      _isLoading = true;
      _showSuggestions = false;
      _currentQuery = query;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _searchResults = SearchService.search(query);
        _isLoading = false;
      });
    });
  }

  void _updateSuggestions(String query) {
    setState(() {
      _searchSuggestions = SearchService.getSearchSuggestions(query);
      _showSuggestions = query.isNotEmpty && _searchSuggestions.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search AsRES 2025'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Enhanced Search Bar
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    _updateSuggestions(value);
                    if (value.isNotEmpty) {
                      _performSearch(value);
                    } else {
                      setState(() {
                        _searchResults = [];
                        _showSuggestions = false;
                        _currentQuery = "";
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText:
                        'Search everything: sessions, speakers, locations, times...',
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.blue),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchResults = [];
                                _searchSuggestions = [];
                                _showSuggestions = false;
                                _currentQuery = "";
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                // Search Suggestions
                if (_showSuggestions) ...[
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: _searchSuggestions.map((suggestion) {
                        return ListTile(
                          dense: true,
                          leading:
                              Icon(Icons.search, color: Colors.grey, size: 20),
                          title: Text(suggestion),
                          onTap: () {
                            _searchController.text = suggestion;
                            _performSearch(suggestion);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Quick Filter Chips
          if (_searchController.text.isEmpty)
            Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                children: [
                  _buildFilterChip(
                      'Schedule', SearchCategory.schedule, Icons.schedule),
                  _buildFilterChip(
                      'Sessions', SearchCategory.sessions, Icons.event),
                  _buildFilterChip(
                      'Networking', SearchCategory.networking, Icons.people),
                  _buildFilterChip(
                      'Location', SearchCategory.location, Icons.place),
                  _buildFilterChip(
                      'Updates', SearchCategory.updates, Icons.update),
                  _buildFilterChip(
                      'Awards', SearchCategory.awards, Icons.emoji_events),
                  _buildFilterChip(
                      'Food', SearchCategory.food, Icons.restaurant),
                ],
              ),
            ),

          // Search Results
          Expanded(
            child: _isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Searching...'),
                      ],
                    ),
                  )
                : _searchResults.isEmpty && _searchController.text.isNotEmpty
                    ? _buildEmptyState()
                    : _searchController.text.isEmpty
                        ? _buildInitialState()
                        : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      String title, IconData icon, SearchCategory category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchResults = SearchService.getResultsByCategory(category);
          _currentQuery = title.toLowerCase();
        });
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(
                result.icon ?? Icons.info,
                color: Colors.blue,
              ),
            ),
            title: HighlightText(
              text: result.title,
              highlight: _currentQuery,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              highlightStyle: TextStyle(
                backgroundColor: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                HighlightText(
                  text: result.description,
                  highlight: _currentQuery,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  highlightStyle: TextStyle(
                    backgroundColor: Colors.yellow,
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.category,
                      size: 14,
                      color: Colors.grey[500],
                    ),
                    SizedBox(width: 4),
                    Text(
                      result.category.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to the specific page
              Navigator.pushNamed(context, result.route);
            },
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
      String label, SearchCategory category, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            SizedBox(width: 4),
            Text(label),
          ],
        ),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _searchResults = SearchService.getResultsByCategory(category);
              _currentQuery = label.toLowerCase();
            });
          }
        },
        backgroundColor: Colors.grey[100],
        selectedColor: Colors.blue[100],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Try different keywords or browse categories',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchResults = [];
                _currentQuery = "";
              });
            },
            child: Text('Clear Search'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          Icon(Icons.search, size: 80, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Search AsRES 2025',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Find anything from the conference',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 30),

          // Popular Searches
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Searches',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: SearchService.getPopularSearches().map((search) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = search;
                        _performSearch(search);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Text(
                          search,
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Search Categories
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Browse Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  children: [
                    _buildCategoryCard(
                        'Schedule', Icons.schedule, SearchCategory.schedule),
                    _buildCategoryCard(
                        'Sessions', Icons.event, SearchCategory.sessions),
                    _buildCategoryCard(
                        'Networking', Icons.people, SearchCategory.networking),
                    _buildCategoryCard(
                        'Location', Icons.place, SearchCategory.location),
                    _buildCategoryCard(
                        'Updates', Icons.update, SearchCategory.updates),
                    _buildCategoryCard(
                        'Awards', Icons.emoji_events, SearchCategory.awards),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
