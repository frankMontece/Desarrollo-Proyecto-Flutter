import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:desarrollo_proyecto_flutter/app/taskflow_app.dart';
import 'package:desarrollo_proyecto_flutter/features/tasks/data/local_task_repository.dart';
import 'package:desarrollo_proyecto_flutter/features/tasks/presentation/tasks_view_model.dart';

void main() {
  testWidgets('TaskFlow muestra la lista de tareas', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TasksViewModel(LocalTaskRepository())..loadTasks(),
        child: const TaskFlowApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mis tareas'), findsOneWidget);
    expect(
      find.text('Terminar informe de Inteligencia de Negocios'),
      findsOneWidget,
    );
  });
}
