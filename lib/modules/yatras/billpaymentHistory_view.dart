import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:flutter/material.dart';

class BillPaymentPage extends StatelessWidget {
  const BillPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bill & Payment History"),
        //subtitle: const Text("Reg #269"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _PaymentStatusCard(),
          SizedBox(height: 16),
          _BillsTable(),
          SizedBox(height: 16),
          _PaymentsTable(),
          SizedBox(height: 16),
          _AllocationTable(),
        ],
      ),
    );
  }
}

class _PaymentStatusCard extends StatelessWidget {
  const _PaymentStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Current Status",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 6),
              Chip(
                label: const Text(
                  "PAID",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: ColorConstant.kPrimary,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "Total Amount",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 6),
              Text(
                "₹ 4,410",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BillsTable extends StatelessWidget {
  const _BillsTable();

  @override
  Widget build(BuildContext context) {
    return _tableWrapper(
      title: "Bills",
      rows: const [
        ["217", "GKGY-269", "2025-12-17", "4,410", "0", "PAID"]
      ],
    );
  }
}

class _PaymentsTable extends StatelessWidget {
  const _PaymentsTable();

  @override
  Widget build(BuildContext context) {
    return _tableWrapper(
      title: "Payments",
      rows: const [
        ["190", "2025-12-17", "4,410", "4,410", "APPLIED", "UPI"]
      ],
    );
  }
}

Widget _tableWrapper({
  required String title,
  required List<List<String>> rows,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: rows
              .map(
                (r) => Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: r
                    .map((e) => Text(e,
                    style: const TextStyle(fontSize: 12)))
                    .toList(),
              ),
            ),
          )
              .toList(),
        ),
      ),
    ],
  );
}

class _AllocationTable extends StatelessWidget {
  const _AllocationTable();

  @override
  Widget build(BuildContext context) {
    return _tableWrapper(
      title: "Allocations",
      rows: const [
        ["189", "4,410", "GKGY-269", "RKBM...14297", "12-17 11:10"]
      ],
    );
  }
}



