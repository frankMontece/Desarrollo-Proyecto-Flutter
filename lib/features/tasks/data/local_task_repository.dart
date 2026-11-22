import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Terminar informe de Inteligencia de Negocios',
      description: 'Redactar conclusiones y revisar el reporte de Power BI',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Estudiar para la evaluación de App Web II',
      description: 'Repasar rutas, controladores y pruebas de la API en Go',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Subir avance de TaskFlow',
      description: 'Hacer commit y push con el README y el modelo Task',
      priority: 'Media',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Preparar exposición de Móviles',
      description: 'Organizar diapositivas y practicar la demostración',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Ordenar apuntes de la semana',
      description: 'Clasificar notas por materia y fecha de entrega',
      priority: 'Baja',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  Future<List<Task>> getTasks() async => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }
}
