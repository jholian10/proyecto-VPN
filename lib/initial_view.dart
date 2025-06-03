import 'package:flutter/material.dart';
import 'dart:async';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  bool isConnected = false;
  String? seleccionActual;

  // Cronómetro
  Timer? _timer;
  int _seconds = 0;

  void _startTimer() {
    _timer?.cancel();
    _seconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
    });
  }

  void _toggleConnection() {
    setState(() {
      isConnected = !isConnected;
      if (isConnected) {
        _startTimer();
      } else {
        _stopTimer();
      }
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _showServersMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Servidor USA'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Servidor Europa'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Servidor Asia'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showAppInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Información de la Aplicación'),
            content: const Text(
              'VPN Free\n\n'
              'Versión: 1.0.0\n'
              'Desarrollado por: Jholian Domiguez Suarez\n\n'
              'Esta aplicación te permite conectarte a servidores VPN para proteger tu privacidad y navegar de forma segura.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 149),
          title: const Text(
            'VPN Free',
            style: TextStyle(color: Color.fromARGB(255, 250, 247, 247)),
          ),

          centerTitle: false,
          elevation: 0,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'info') {
                  _showAppInfoDialog(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'info',
                    child: Text('Información de la aplicación'),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://www.xtrafondos.com/wallpapers/tigre-de-neon-artwork-4673.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Botón "close"
                ElevatedButton(
                  onPressed: () => _showServersMenu(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 255, 0, 149),
                      width: 5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 200,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'close',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Cuadro seleccionables
                Container(
                  padding: const EdgeInsets.all(00),
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0.8),
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 0, 149),
                      width: 5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'UDP',
                                groupValue: seleccionActual,
                                onChanged: (value) {
                                  setState(() => seleccionActual = value);
                                },
                              ),
                              const Text('   UDP'),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'WireGuard',
                                groupValue: seleccionActual,
                                onChanged: (value) {
                                  setState(() => seleccionActual = value);
                                },
                              ),
                              const Text('   WireGuard'),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'FastDnS',
                                groupValue: seleccionActual,
                                onChanged: (value) {
                                  setState(() => seleccionActual = value);
                                },
                              ),
                              const Text('   FastDnS'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Botón principal redondo
                ElevatedButton(
                  onPressed: _toggleConnection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 231, 231, 231),
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Color.fromARGB(255, 235, 14, 14),
                    ),
                    padding: const EdgeInsets.all(37),
                    shape: const CircleBorder(),
                    elevation: 5,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        isConnected ? 'Stop' : 'Start',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 235, 14, 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Cronómetro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Duration: ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 25, 255),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _formatTime(_seconds),
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            isConnected
                                ? const Color.fromARGB(255, 25, 0, 255)
                                : const Color.fromARGB(255, 25, 0, 255),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Configuración
                const Text(
                  'Configuración: 1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
