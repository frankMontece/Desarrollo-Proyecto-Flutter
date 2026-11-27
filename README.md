# desarrollo_proyecto_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Alcance de TaskFlow

Problema: necesito organizar actividades académicas y saber cuáles faltan.
Usuario objetivo: estudiante que planifica entregas semanales.

### Historias de usuario y criterios de aceptación
1. Como estudiante, quiero listar mis tareas para ver qué debo hacer.
   Criterio: la lista muestra título, prioridad y estado de cada tarea.
2. Como estudiante, quiero abrir una tarea para leer su descripción.
   Criterio: al tocar una tarjeta aparece el detalle de la tarea elegida.
3. Como estudiante, quiero crear una tarea para registrar un pendiente.
   Criterio: el formulario guarda una tarea válida y la lista la muestra.
4. Como estudiante, quiero editar una tarea para corregir sus datos.
   Criterio: los cambios guardados aparecen en lista y detalle.
5. Como estudiante, quiero eliminar una tarea terminada para limpiar la lista.
   Criterio: después de confirmar, la tarea desaparece de la lista.

### Modelo de datos
Task: id (entero único), title (texto), description (texto),
priority (Alta, Media o Baja), isCompleted (verdadero/falso),
userId (entero que identifica al usuario de prueba).

### Contrato de API que necesitaremos a futuro
GET /tasks        listar tareas
GET /tasks/:id    consultar detalle
POST /tasks       crear tarea
PATCH /tasks/:id  actualizar tarea
DELETE /tasks/:id eliminar tarea

## API de tareas

- **Endpoint base:** `https://jsonplaceholder.typicode.com/todos`
- **Filtro aplicado:** Parámetro `userId=2` (obtiene únicamente las tareas del usuario seleccionado).
- **Campos recibidos de la API:** `id`, `userId`, `title` y `completed` (mapeado a `isCompleted`).
- **Valores completados por defecto en TaskFlow:** `description` ("Sin descripción (API)") y `priority` ("Sin prioridad (API)").
- **Persistencia:** La acción de marcar/desmarcar una tarea como completada actualiza únicamente la memoria local temporalmente; al reiniciar la app se vuelven a consultar los datos originales del servidor.

## Formulario de creación (Sesión 9)

- **Ruta declarativa:** `/new` renderiza `TaskFormScreen`.
- **Validaciones:** El campo título es obligatorio y exige un mínimo de 3 caracteres mediante `GlobalKey<FormState>` y `TextFormField.validator`.
- **Campos adicionales:** Descripción multilínea, selector de prioridad (`Alta`, `Media`, `Baja`) y selector de fecha límite opcional mediante `showDatePicker`.
- **Retorno de datos:** Al validar correctamente, `context.pop(draft)` devuelve una instancia de `TaskDraft` a `TaskListScreen`, mostrándose en un `SnackBar` previo a la integración `POST` de la siguiente sesión.
## Operaciones CRUD en TaskFlow (Sesión 10)

- **Crear (`POST /todos`):** Envía el título y el `userId` desde `TaskFormScreen` y añade la tarea confirmada al estado reactivo de la lista.
- **Actualizar (`PATCH /todos/:id`):** Permite modificar el título desde `TaskDetailScreen` mediante un diálogo controlado y sincroniza la vista.
- **Eliminar (`DELETE /todos/:id`):** Solicita confirmación mediante `AlertDialog` antes de ejecutar la petición y remover el elemento del listado.
- **Nota sobre persistencia:** JSONPlaceholder simula las operaciones de escritura (`HTTP 200 / 201`), pero no almacena los cambios de forma permanente en su servidor; al recargar la consulta `GET`, se recuperan los registros originales.
