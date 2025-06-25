import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentUpdatePage extends StatefulWidget {
  @override
  _RecentUpdatePageState createState() => _RecentUpdatePageState();
}

class _RecentUpdatePageState extends State<RecentUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Recent Updates',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recent Updates Section
            _buildSectionTitle('Recent Updates'),
            SizedBox(height: 12),
            _buildUpdatesStream(),

            SizedBox(height: 24),

            // Created Events Section
            _buildSectionTitle('New Events'),
            SizedBox(height: 12),
            _buildCreatedEventsStream(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildUpdatesStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Admin')
          .doc('recent_updates')
          .collection('updates')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorCard('Error loading updates: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingCard();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyCard('No recent updates available');
        }

        return Column(
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return _buildUpdateCard(
              update: data['update'] ?? 'No update text',
              timestamp: data['timestamp'] != null
                  ? (data['timestamp'] as Timestamp).toDate()
                  : DateTime.now(),
              updatedBy: data['updatedBy'] ?? 'Unknown',
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCreatedEventsStream() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Admin')
          .doc('created_event')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorCard('Error loading events: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingCard();
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return _buildEmptyCard('No created events available');
        }

        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        // Extract events array and last updated timestamp
        List<dynamic> events = data['events'] ?? [];
        dynamic lastUpdated = data['LastUpdated'];

        if (events.isEmpty) {
          return _buildEmptyCard('No events created yet');
        }

        return _buildEventsColumn(events, lastUpdated);
      },
    );
  }

  Widget _buildUpdateCard({
    required String update,
    required DateTime timestamp,
    required String updatedBy,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              update,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'By: $updatedBy',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  _formatDateTime(timestamp),
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
    );
  }

  Widget _buildEventsColumn(List<dynamic> events, dynamic lastUpdated) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Last Updated Header
        if (lastUpdated != null) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, size: 16, color: Colors.blue[700]),
                SizedBox(width: 6),
                Text(
                  'Last Updated: ${_formatFieldValue(lastUpdated)}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],

        // Events List
        ...events.map((event) => _buildSingleEventCard(event)).toList(),
      ],
    );
  }

  Widget _buildSingleEventCard(dynamic eventData) {
    Map<String, dynamic> event = {};

    // Handle different data types
    if (eventData is Map<String, dynamic>) {
      event = eventData;
    } else if (eventData is String) {
      // If it's still coming as string, try to parse it
      event = _parseEventString(eventData);
    }

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey[50]!],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Title
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.event, color: Colors.blue[700], size: 20),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      event['a-title'] ?? event['title'] ?? 'Untitled Event',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Event Details
              _buildEventDetails(event),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetails(Map<String, dynamic> event) {
    return Column(
      children: [
        // Date and Time Row
        Row(
          children: [
            Expanded(
              child: _buildDetailChip(
                Icons.calendar_today,
                'Date',
                event['date'] ?? 'Not specified',
                Colors.green,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildDetailChip(
                Icons.access_time,
                'Time',
                '${event['startTime'] ?? ''} - ${event['endTime'] ?? ''}',
                Colors.orange,
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        // Location
        if (event['location'] != null &&
            event['location'].toString().isNotEmpty)
          _buildDetailRow(
              Icons.location_on, 'Location', event['location'], Colors.red),

        // Overview
        if (event['overview'] != null &&
            event['overview'].toString().isNotEmpty) ...[
          SizedBox(height: 12),
          _buildDetailRow(
              Icons.info_outline, 'Overview', event['overview'], Colors.purple),
        ],
      ],
    );
  }

  Widget _buildDetailChip(
      IconData icon, String label, String value, MaterialColor color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color[700]),
              SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, dynamic value, MaterialColor color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color[700]),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color[700],
            ),
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _parseEventString(String eventString) {
    Map<String, dynamic> eventData = {};

    // Basic parsing for string format events
    List<String> parts = eventString.split(', ');
    for (String part in parts) {
      if (part.contains(':')) {
        List<String> keyValue = part.split(':');
        if (keyValue.length >= 2) {
          String key = keyValue[0].trim();
          String value = keyValue.sublist(1).join(':').trim();
          eventData[key] = value;
        }
      }
    }

    return eventData;
  }

  Widget _buildLoadingCard() {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCard(String message) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatFieldName(String fieldName) {
    return fieldName
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word.isEmpty ? word : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatFieldValue(dynamic value) {
    if (value is Timestamp) {
      return _formatDateTime(value.toDate());
    } else if (value is List) {
      return value.join(', ');
    } else if (value is Map) {
      return value.toString();
    }
    return value.toString();
  }
}
