import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'task.dart';

void main() {
  runApp(const TaskFlowApp());
}

// 1. DATOS Y MODELOS
// Actualizamos los datos para incluir el userId: 1
const demoTasks = <Task>[
  Task(id: 1, title: 'Terminar informe de Inteligencia de Negocios', description: 'Redactar conclusiones y revisar el reporte de Power BI', priority: 'Alta', isCompleted: false, userId: 1),
  Task(id: 2, title: 'Estudiar para la evaluación de App Web II', description: 'Repasar rutas, controladores y pruebas de la API en Go', priority: 'Alta', isCompleted: false, userId: 1),
  Task(id: 3, title: 'Subir avance de TaskFlow', description: 'Hacer commit y push con el README y el modelo Task', priority: 'Media', isCompleted: true, userId: 1),
  Task(id: 4, title: 'Preparar exposición de Móviles', description: 'Organizar diapositivas y practicar la demostración', priority: 'Media', isCompleted: false, userId: 1),
  Task(id: 5, title: 'Ordenar apuntes de la semana', description: 'Clasificar notas por materia y fecha de entrega', priority: 'Baja', isCompleted: false, userId: 1),
];

// 2. CONFIGURACIÓN DE RUTAS
Task? findTask(int? id) {
  for (final task in demoTasks) {
    if (task.id == id) return task;
  }
  return null; // Devuelve nulo si no lo encuentra en vez de explotar
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TaskListScreen(),
    ),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        // Usamos tryParse para evitar errores si no es un número
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        // Pasamos el objeto Task entero, en lugar de solo el ID
        return TaskDetailScreen(task: findTask(id)); 
      },
    ),
  ],
);

// 3. APLICACIÓN PRINCIPAL (Unificada)
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos MaterialApp.router para habilitar go_router
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

// 4. PANTALLAS Y WIDGETS

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tareas')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];
          return TaskCard(
            task: task,
            // [CORRECCIÓN] Usando interpolación de strings en lugar de concatenación
            onTap: () => context.push('/task/${task.id}'),
          );
        },
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(task.title),
        // [CORRECCIÓN] Interpolación en lugar de: task.priority + ' · ' + task.description
        subtitle: Text('${task.priority} · ${task.description}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

// 5. PANTALLA DE DETALLE DE TAREA
class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.task});

  final Task? task; // Ahora recibe la tarea (que puede ser nula)

  @override
  Widget build(BuildContext context) {
    // Verificamos si la tarea existe
    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No se encontró esta tarea.')),
      );
    }

    // Si existe, desempaquetamos de forma segura
    final selected = task!;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de tarea')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(selected.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text(selected.description),
            const SizedBox(height: 16),
            Chip(label: Text('Prioridad: ${selected.priority}')),
            const SizedBox(height: 12),
            Text(selected.isCompleted ? 'Estado: completada' : 'Estado: pendiente'),
            const SizedBox(height: 12),
            Text('Usuario: ${selected.userId}'), // <- Mostramos el nuevo campo
            const Spacer(),
            FilledButton.tonalIcon(
              onPressed: () => context.pop(), 
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver al listado'),
            ),
          ],
        ),
      ),
    );
  }
}

// (Opcional) Pantalla de la sesión anterior que tenías en tu código
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String studentName = 'Frank Montece Cagua';
  int pendingTasks = 3;
  static const dailyGoal = 5;
  int completedTasks = 0;

  void _addTask() {
    setState(() {
      pendingTasks++;
    });
  }

  void _completeTask() {
    if (pendingTasks == 0) {
      return;
    }

    setState(() {
      pendingTasks--;
      if (completedTasks < dailyGoal) {
        completedTasks++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusMessage = pendingTasks == 0
        ? '¡Excelente! No tienes tareas pendientes.'
        : 'Aún tienes tareas por organizar.';

    return Scaffold(
      appBar: AppBar(title: const Text('Desarrollo Móvil'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(statusMessage),
            Text('Completadas hoy: $completedTasks de $dailyGoal'),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions),
                    const SizedBox(width: 12),
                    Text('Tareas pendientes: $pendingTasks'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar tarea'),
                ),
                OutlinedButton.icon(
                  onPressed: pendingTasks == 0 ? null : _completeTask,
                  icon: const Icon(Icons.done),
                  label: const Text('Completar una tarea'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
