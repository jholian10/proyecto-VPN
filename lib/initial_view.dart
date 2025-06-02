import 'package:flutter/material.dart';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  bool isConnected = false;

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
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Servidor Europa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Servidor Asia'),
              onTap: () {
                Navigator.pop(context);
              },
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 22, 224),
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
                // Ícono Wi-Fi
                const Icon(
                  Icons.wifi,
                  size: 80,
                  color: Color.fromARGB(255, 187, 43, 43),
                ),

                const SizedBox(height: 20),

                // Botón "Servidores" con flecha
                ElevatedButton(
                  onPressed: () => _showServersMenu(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Servidores',
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

                const SizedBox(height: 30),

                // Botón redondo central
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isConnected = !isConnected;
                    });
                  },
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

                // Estado
                Text(
                  isConnected ? 'Conectado' : 'Desconectado',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isConnected ? Colors.green : Colors.red,
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
