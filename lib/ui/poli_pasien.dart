import 'package:flutter/material.dart';
import 'package:klinik_app/ui/poli_form.dart';
import 'package:klinik_app/ui/poli_item.dart';
import 'package:klinik_app/ui/poli_sidebar.dart';
import '../model/poli.dart';
import '../service/poli_service.dart';

class PoliPasien extends StatefulWidget {
  const PoliPasien({super.key});

  @override
  State<PoliPasien> createState() => _PoliPasienState();
}

class _PoliPasienState extends State<PoliPasien> {
  Stream<List<Poli>> getList() async* {
    List<Poli> data = await PoliService().listData();
    yield data;
  }

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PoliSidebar(),
      appBar: AppBar(
        title: const Text("Data Pasien"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PoliForm()));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: StreamBuilder(
          stream: getList(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Text("Data Kosong");
            }

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return PoliItem(poli: snapshot.data[index]);
                });
          },
        ),
      ),
    );
  }
}
