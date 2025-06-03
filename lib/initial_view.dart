import 'package:flutter/material.dart';
import 'dart:async';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  bool isConnected = false;

  // Seleccionables
  bool opcion1 = false;
  bool opcion2 = false;
  bool opcion3 = false;

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
              'Desarrollado por: Tu Nombre\n\n'
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
    _timer?.cancel(); // Cancelar al destruir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 207, 6, 164),
          title: const Text(
            'VPN Free',
            style: TextStyle(color: Color.fromARGB(255, 250, 247, 247)),
          ),
          centerTitle: true,
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
                // Botón "Servidores"
                ElevatedButton(
                  onPressed: () => _showServersMenu(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
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
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Cuadro seleccionables
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      167,
                      84,
                      84,
                    ).withOpacity(0.9),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: opcion1,
                            onChanged: (value) {
                              setState(() => opcion1 = value!);
                            },
                          ),
                          const Text('     UDP     '),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: opcion2,
                            onChanged: (value) {
                              setState(() => opcion2 = value!);
                            },
                          ),
                          const Text('     WireGuard     '),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: opcion3,
                            onChanged: (value) {
                              setState(() => opcion3 = value!);
                            },
                          ),
                          const Text('     FastDnS     '),
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
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(50),
                    shape: const CircleBorder(),
                    elevation: 10,
                  ),
                  child: Icon(
                    Icons.power_settings_new,
                    size: 30,
                    color: isConnected ? Colors.green : Colors.red,
                  ),
                ),

                const SizedBox(height: 20),

                // Estado de conexión
                Text(
                  isConnected ? 'Conectado' : 'Desconectado',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isConnected ? Colors.green : Colors.red,
                  ),
                ),

                const SizedBox(height: 10),

                // Cronómetro
                if (isConnected)
                  Text(
                    _formatTime(_seconds),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 25, 0, 255),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                const SizedBox(height: 20),

                // Configuración
                const Text(
                  'Configuración: 1.0',
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
