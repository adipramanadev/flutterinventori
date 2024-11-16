import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GpsReaderPage extends StatefulWidget {
  const GpsReaderPage({super.key});

  @override
  State<GpsReaderPage> createState() => _GpsReaderPageState();
}

class _GpsReaderPageState extends State<GpsReaderPage> {
  String? _latitude;
  String? _longitude;
  String? _address; //menyimpan alamat lokasi
  bool _isLoading = false;

  //fungsi untuk mendapatkan lokasi
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    LocationPermission permission;

    //meminta ijin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      //jika ijin lokasi di tolak
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Izin lokasi di perlukan untuk menggunakan aplikasi ini .'),
          ),
        );
        setState(() {
          _isLoading = false;
        });

        return;
      }
    }

    //mendapatkan lokasi terkini
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setState(() {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
        _isLoading = false;
      });

      //mendapatkan alamat dari latitude dan longitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      //ambil alamat 
      Placemark place = placemarks[0];
      setState(() {
        _address = "${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.locality}"; 
        _isLoading = false; 
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal MEndapatkan lokasi : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Terkini'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _latitude != null && _longitude != null
                          ? 'Latitude $_latitude\nLongitude : $_longitude'
                          : 'Tekan Tombol untuk mendapatkan Lokasi',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: _getCurrentLocation,
                      child: const Text('Get Lokasi'),
                    )
                  ],
                )),
    );
  }
}
