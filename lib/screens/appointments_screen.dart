import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> upcomingAppointments = [
    {'service': 'Hair Styling', 'date': 'Dec 15, 2025', 'time': '10:00 AM', 'price': '₦8,000', 'status': 'Confirmed', 'icon': Icons.brush, 'color': Colors.pink},
    {'service': 'Hair Treatment', 'date': 'Dec 20, 2025', 'time': '02:00 PM', 'price': '₦15,000', 'status': 'Pending', 'icon': Icons.spa, 'color': Colors.blue},
  ];

  final List<Map<String, dynamic>> pastAppointments = [
    {'service': 'Haircut', 'date': 'Dec 5, 2025', 'time': '11:00 AM', 'price': '₦5,000', 'status': 'Completed', 'icon': Icons.content_cut, 'color': Colors.orange},
    {'service': 'Hair Coloring', 'date': 'Nov 28, 2025', 'time': '03:00 PM', 'price': '₦12,000', 'status': 'Completed', 'icon': Icons.palette, 'color': Colors.purple},
  ];

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
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('My Appointments', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF8B5CF6),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF8B5CF6),
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Past')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentsList(upcomingAppointments, isUpcoming: true),
          _buildAppointmentsList(pastAppointments, isUpcoming: false),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: const Color(0xFF8B5CF6),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/home');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/booking'),
        backgroundColor: const Color(0xFF8B5CF6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAppointmentsList(List<Map<String, dynamic>> appointments, {required bool isUpcoming}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) => _buildAppointmentCard(appointments[index], isUpcoming),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment, bool isUpcoming) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: appointment['color'].withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(appointment['icon'], color: appointment['color'], size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointment['service'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(appointment['date'], style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                          const SizedBox(width: 16),
                          Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(appointment['time'], style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(appointment['price'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6))),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: _getStatusColor(appointment['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(appointment['status'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _getStatusColor(appointment['status']))),
                ),
                const Spacer(),
                if (isUpcoming) ...[
                  TextButton(onPressed: () => _showCancelDialog(context), child: const Text('Cancel', style: TextStyle(color: Colors.red))),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/booking'),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: const Text('Reschedule', style: TextStyle(color: Colors.white)),
                  ),
                ] else
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/booking'),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: const Text('Book Again', style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed': return Colors.green;
      case 'Pending': return Colors.orange;
      case 'Completed': return Colors.blue;
      case 'Cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Cancel Appointment', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Are you sure you want to cancel this appointment?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment cancelled'), backgroundColor: Colors.red));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Yes, Cancel', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}