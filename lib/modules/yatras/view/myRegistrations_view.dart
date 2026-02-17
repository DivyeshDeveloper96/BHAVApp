import 'package:flutter/material.dart';

class MyRegistrationsView extends StatelessWidget {
  const MyRegistrationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _RegistrationCard(
            regId: "YATRA24-1056",
            name: "Saanvi Sharma",
            members: 4,
            total: "₹12,000",
            status: "Draft",
            statusColor: Colors.orange,
          ),
          _RegistrationCard(
            regId: "YATRA24-1021",
            name: "Rajesh Kumar",
            members: 2,
            total: "₹6,000",
            status: "Confirmed",
            statusColor: Colors.green,
          ),
          _RegistrationCard(
            regId: "YATRA24-0985",
            name: "Priya Singh",
            members: 1,
            total: "₹3,000",
            status: "Cancelled",
            statusColor: Colors.red,
            disabled: true,
          ),
        ],
      ),
    );
  }
}

class _RegistrationCard extends StatelessWidget {
  final String regId;
  final String name;
  final int members;
  final String total;
  final String status;
  final Color statusColor;
  final bool disabled;

  const _RegistrationCard({
    required this.regId,
    required this.name,
    required this.members,
    required this.total,
    required this.status,
    required this.statusColor,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.6 : 1,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reg ID: $regId",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Chip(
                    label: Text(status),
                    backgroundColor: statusColor.withOpacity(.15),
                    labelStyle: TextStyle(color: statusColor),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text("Primary: $name"),
              Text("Members: $members"),
              Text("Total: $total",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

