import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<Map<String, dynamic>> _bills = [
    {
      "title": "Monthly Rent",
      "amount": 25000,
      "due": "01/04/2026",
      "paid": false,
    },
    {
      "title": "Water Bill",
      "amount": 1500,
      "due": "15/04/2026",
      "paid": false,
    },
    {
      "title": "Electricity Bill",
      "amount": 3200,
      "due": "15/04/2026",
      "paid": true,
    },
    {
      "title": "Maintenance Fee",
      "amount": 2000,
      "due": "01/04/2026",
      "paid": true,
    },
  ];

  void _payBill(int index) {
    setState(() {
      _bills[index]["paid"] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${_bills[index]["title"]} paid successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int unpaid = _bills.where((b) => b["paid"] == false).length;
    int totalUnpaid = _bills
        .where((b) => b["paid"] == false)
        .fold(0, (sum, b) => sum + (b["amount"] as int));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Summary
            Card(
              color: Colors.indigo.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.indigo),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Unpaid Bills",
                            style: TextStyle(color: Colors.grey)),
                        Text(
                          "$unpaid bills",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Total Due",
                            style: TextStyle(color: Colors.grey)),
                        Text(
                          "$totalUnpaid DZD",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Bills list
            Expanded(
              child: ListView.builder(
                itemCount: _bills.length,
                itemBuilder: (context, index) {
                  final bill = _bills[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: bill["paid"]
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                        child: Icon(
                          bill["paid"] ? Icons.check : Icons.receipt,
                          color: bill["paid"] ? Colors.green : Colors.red,
                        ),
                      ),
                      title: Text(
                        bill["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Due: ${bill["due"]}"),
                      trailing: bill["paid"]
                          ? const Chip(
                              label: Text("Paid",
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                            )
                          : ElevatedButton(
                              onPressed: () => _payBill(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                              ),
                              child: Text(
                                "${bill["amount"]} DZD",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}