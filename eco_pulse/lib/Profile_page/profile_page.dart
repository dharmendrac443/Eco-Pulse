import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              radius: 16,
            ),
            SizedBox(width: 10),
            Text('Profile'),
          ],
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _actionButtons(),
                  SizedBox(height: 24),
                  _monthYearSelector(),
                  SizedBox(height: 24),
                  isLoading ? CircularProgressIndicator() : _chart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.tealAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://picsum.photos/200/300'),
            ),
            SizedBox(height: 10),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'john.doe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[200]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _showEditProfileDialog(context),
          icon: Icon(Icons.edit),
          label: Text('Edit Profile'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () => _showChangePasswordDialog(context),
          icon: Icon(Icons.lock),
          label: Text('Change Password'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _monthYearSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Selected: ${DateFormat.yMMM().format(selectedDate)}",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () async {
            setState(() => isLoading = true);
            DateTime? picked = await showMonthPicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() => selectedDate = picked);
            }
            setState(() => isLoading = false);
          },
          icon: Icon(Icons.calendar_today),
          label: Text("Select Month"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _chart() {
    return SfCircularChart(
      title: ChartTitle(text: 'Data for ${DateFormat.yMMM().format(selectedDate)}'),
      legend: Legend(isVisible: true),
      series: <DoughnutSeries<ChartData, String>>[
        DoughnutSeries<ChartData, String>(
          dataSource: getChartData(),
          xValueMapper: (ChartData data, _) => data.department,
          yValueMapper: (ChartData data, _) => data.count,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          explode: true,
          explodeIndex: 0,
        )
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<ChartData> getChartData() {
    return selectedDate.month == DateTime.now().month
        ? [
            ChartData('Electricity', 15.2),
            ChartData('Transport', 18.2),
            ChartData('Food', 12.1),
            ChartData('Cloth', 24.2),
          ]
        : [
            ChartData('Electricity', 10.0),
            ChartData('Transport', 20.0),
            ChartData('Food', 8.0),
            ChartData('Cloth', 30.0),
          ];
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: InputDecoration(labelText: 'Name')),
              TextField(decoration: InputDecoration(labelText: 'Email')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Save')),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: InputDecoration(labelText: 'Old Password'), obscureText: true),
              TextField(decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
              TextField(decoration: InputDecoration(labelText: 'Confirm Password'), obscureText: true),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Change')),
          ],
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.department, this.count);
  final String department;
  final double count;
}
