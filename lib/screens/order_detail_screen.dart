import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width / 100 * 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _widgetTextTitle(context, 'Pemesan'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2,
              ),
              _widgetTextCustomerData(context, 'Nama Pemesan'),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
              _widgetTextTitle(context, 'Alamat'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2,
              ),
              _widgetTextCustomerData(context, 'Alamat Pemesan'),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
              _widgetTextTitle(context, 'Tanggal Pesan'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2,
              ),
              _widgetTextCustomerData(context, 'Tanggal Pesan'),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
              _widgetTextTitle(context, 'Jam Pesan'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2,
              ),
              _widgetTextCustomerData(context, 'Jam Pesan'),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
              _widgetTextTitle(context, 'Nama Lapangan'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2,
              ),
              _widgetTextCustomerData(context, 'Nama Lapangan'),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
              _widgetTextTitle(context, 'Jenis Lapangan'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2,
              ),
              _widgetTextCustomerData(context, 'Jenis Lapangan'),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
              _widgetTextTitle(context, 'Harga'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2,
              ),
              _widgetTextCustomerData(context, 'Harga'),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
              _widgetTextTitle(context, 'Status Pesanan'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 2,
              ),
              _widgetTextCustomerData(context, 'Status Pemesan'),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 100 * 5.5,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Terima Pesanan'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100 * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _widgetTextCustomerData(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 5.5,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text _widgetTextTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 100 * 4.5,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
