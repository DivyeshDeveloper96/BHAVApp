import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class RegistrationDetailsView extends StatelessWidget {
  const RegistrationDetailsView({super.key});

  static const primary = Color(0xFF7E22CE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// APP BAR
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Registration Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Back to list", style: TextStyle(color: primary)),
          ),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// SUMMARY CARD
            _summaryCard(),

            const SizedBox(height: 16),

            /// GENERAL INFO
            _sectionCard(
              title: "General Info",
              icon: Icons.info,
              child: Column(
                children: [
                  _infoRow("Brahmachari", "No"),
                  _infoRow("From Pune", "No — Mumbai"),
                  _infoRow("Transport", "Own"),
                  _infoRow("Main accommodation", "Rooms Mix"),
                  _infoRow("Pune stay", "No"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// PARTICIPANTS
            _sectionCard(
              title: "Participants",
              icon: Icons.groups,
              trailing: _badge("2"),
              child: Column(
                children: const [
                  _ParticipantTile(
                    name: "Divya Shyam Das",
                    age: "Male, 29 yrs",
                    phone: "9819780656",
                    primary: true,
                  ),
                  Divider(),
                  _ParticipantTile(
                    name: "Anuradha Devi Dasi",
                    age: "Female, 25 yrs",
                    phone: "9082600516",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// PAYMENT BREAKUP
            _sectionCard(
              title: "Payment Breakup",
              icon: Icons.receipt_long,
              child: Column(
                children: [
                  _amountRow("Base fee", "₹ 4,200"),
                  _amountRow("Transport (Own)", "₹ 0"),
                  _amountRow("Rooms", "₹ 0"),
                  _amountRow("Mattresses", "₹ 0"),
                  const Divider(),
                  _amountRow("Sub Total", "₹ 4,200", bold: true),
                  _amountRow("GST (5%)", "₹ 210"),
                  const Divider(),
                  _amountRow(
                    "Grand Total",
                    "₹ 4,410",
                    bold: true,
                    highlight: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: "Yatras",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  /// ---------- WIDGETS ----------

  static Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(left: BorderSide(color: primary, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Registration #269",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Submission Date: Oct 24, 2023",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              _statusBadge(),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "₹4,410.00",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coming",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Group/Family (2)",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _sectionCard({
    required String title,
    required IconData icon,
    Widget? trailing,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primary.withOpacity(.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                const Spacer(),
                if (trailing != null) trailing,
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  static Widget _amountRow(
    String label,
    String value, {
    bool bold = false,
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: highlight ? primary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          CircleAvatar(radius: 4, backgroundColor: Colors.green),
          SizedBox(width: 6),
          Text(
            "Paid",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class _ParticipantTile extends StatelessWidget {
  final String name;
  final String age;
  final String phone;
  final bool primary;

  const _ParticipantTile({
    required this.name,
    required this.age,
    required this.phone,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  age,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            if (primary)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "Primary",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.phone, size: 16, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              phone,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
