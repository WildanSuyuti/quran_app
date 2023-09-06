import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const route = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _response;
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Surat'),
      ),
      body: _response == null
          ? Visibility(
              visible: _isLoading,
              child: const Center(child: CircularProgressIndicator()),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: _response == null ? 0 : _response!['data'].length,
                itemBuilder: (_, i) {
                  if (_response != null) {
                    Map<String, dynamic> item = _response!['data'][i];
                    final nomor = item['nomor'];
                    final nama = item['nama'];
                    final namaLatin = item['namaLatin'];
                    final tempatTurun = item['tempatTurun'];
                    final jumlahAyat = item['jumlahAyat'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Text(nomor.toString()),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                namaLatin,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$tempatTurun - $jumlahAyat Ayat'.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Text(
                              nama,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff863ED5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
    );
  }

  _fetchData() async {
    setState(() => _isLoading = true);
    var client = http.Client();
    try {
      final result = await client.get(Uri.https('equran.id', 'api/v2/surat'));
      _response = jsonDecode(result.body);
      debugPrint('HASIL RESPONSE:\n$_response');
    } catch (e) {
      debugPrint('error -> $e');
    } finally {
      debugPrint('finally is called');
      setState(() => _isLoading = false);
      client.close();
    }
  }
}

/*
class HomePage extends StatefulWidget {
  static const route = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _response;
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Surat'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _fetchData,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.green,
                child: const Text(
                  'AmbilData',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: _response != null,
              child: Expanded(
                child: ListView.builder(
                  itemCount: _response == null ? 0 : _response!['data'].length,
                  itemBuilder: (_, i) {
                    if (_response != null) {
                      Map<String, dynamic> item = _response!['data'][i];
                      final nomor = item['nomor'];
                      final nama = item['nama'];
                      final namaLatin = item['namaLatin'];
                      final tempatTurun = item['tempatTurun'];
                      final jumlahAyat = item['jumlahAyat'];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Text(nomor.toString()),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  namaLatin,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$tempatTurun - $jumlahAyat Ayat'
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                nama,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff863ED5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  _fetchData() async {
    setState(() => _isLoading = true);
    var client = http.Client();
    try {
      final result = await client.get(Uri.https('equran.id', 'api/v2/surat'));
      _response = jsonDecode(result.body);
      debugPrint('HASIL RESPONSE:\n$_response');
    } catch (e) {
      debugPrint('error -> $e');
    } finally {
      debugPrint('finally is called');
      setState(() => _isLoading = false);
      client.close();
    }
  }
}
*/
