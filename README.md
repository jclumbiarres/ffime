# FFIME - Foreign Function Interface Made Easy

Un proyecto de aprendizaje para dominar FFI (Foreign Function Interface) entre **Gleam** y **Erlang**, utilizando **Mnesia** como base de datos distribuida.

## 🚀 Descripción

FFIME demuestra cómo crear una integración limpia entre Gleam y Erlang, específicamente mostrando:

- **FFI de Gleam a Erlang**: Llamadas desde código Gleam a funciones nativas de Erlang
- **Base de datos Mnesia**: Configuración, creación de tablas y operaciones CRUD
- **Nodos distribuidos**: Configuración de nodos Erlang con nombres cortos
- **Manejo de errores**: Gestión robusta de errores entre ambos lenguajes

## 📁 Estructura del Proyecto

```
ffime/
├── src/
│   ├── ffime.gleam          # Punto de entrada principal
│   └── ffi/
│       ├── mnesia.gleam     # Definiciones FFI para Gleam
│       └── database.erl     # Implementación en Erlang
└── README.md
```

## 🔧 Componentes

### 1. Módulo Principal (`src/ffime.gleam`)

```gleam
import ffi/mnesia
import gleam/io
import gleam/string

pub fn main() {
  io.println("Starting...")
  let _init_result = mnesia.init()
  io.println("Init done")
  
  let add_result = mnesia.add_user(1, "Juan")
  io.println("Add done")
  
  let get_result = mnesia.get_user(1)
  io.println("Get done")
  
  io.println("Add result:")
  io.println(string.inspect(add_result))
  io.println("Get result:")
  io.println(string.inspect(get_result))
}
```

**Funcionalidad:**
- Inicializa la base de datos Mnesia
- Crea un usuario de prueba
- Consulta el usuario creado
- Muestra los resultados de todas las operaciones

### 2. Interface FFI (`src/ffi/mnesia.gleam`)

```gleam
@external(erlang, "database", "init")
pub fn init() -> String

@external(erlang, "database", "add_user")
pub fn add_user(id: Int, name: String) -> String

@external(erlang, "database", "get_user")
pub fn get_user(id: Int) -> String
```

**Funcionalidad:**
- Define las funciones externas que llaman al código Erlang
- Especifica los tipos de entrada y salida para cada función
- Actúa como puente entre Gleam y Erlang

### 3. Implementación Erlang (`src/ffi/database.erl`)

#### Función `init/0`
- Inicia un nodo distribuido con nombre corto `ffime`
- Configura y crea el schema de Mnesia
- Crea la tabla `user` con persistencia en disco
- Maneja errores de forma robusta

#### Función `add_user/2`
- Crea un nuevo registro de usuario
- Ejecuta la operación dentro de una transacción Mnesia
- Retorna `"ok"` en caso de éxito o descripción del error

#### Función `get_user/1`
- Busca un usuario por ID
- Retorna `"found: <nombre>"` si existe o `"not_found"` si no existe
- Maneja errores de transacción

## 🏗️ Características Técnicas

### Base de Datos Mnesia
- **Tipo**: Base de datos distribuida embebida
- **Persistencia**: `disc_copies` - datos almacenados en disco
- **Tabla**: `user` con campos `id` y `name`
- **Transacciones**: Todas las operaciones son transaccionales

### Nodo Distribuido
- **Nombre**: `ffime` (nombre corto)
- **Tipo**: `shortnames` para desarrollo local
- **Auto-configuración**: Se configura automáticamente en `init/0`

### Manejo de Errores
- **Try-catch**: Captura excepciones en la inicialización
- **Pattern matching**: Manejo específico de diferentes tipos de errores
- **Strings de respuesta**: Todos los errores se convierten a strings legibles

## 🚀 Uso

### Prerrequisitos
- **Gleam** instalado
- **Erlang/OTP** instalado

### Ejecución
```bash
# Clonar el repositorio
git clone https://github.com/jclumbiarres/ffime.git
cd ffime

# Ejecutar el proyecto
gleam run --target erlang
```

### Salida esperada
```
Starting...
Init done
Add done
Get done
Add result:
"ok"
Get result:
"found: Juan"
```

## 📚 Conceptos Aprendidos

1. **FFI (Foreign Function Interface)**
   - Definición de funciones externas en Gleam
   - Mapeo de tipos entre Gleam y Erlang
   - Manejo de valores de retorno

2. **Mnesia Database**
   - Configuración de nodos distribuidos
   - Creación de schemas y tablas
   - Operaciones CRUD transaccionales

3. **Interoperabilidad Gleam-Erlang**
   - Conversión de tipos de datos
   - Manejo de strings y charlists
   - Gestión de errores entre lenguajes

## 📄 Licencia

Distribuido bajo la Licencia Apache 2.0. Ver `LICENSE` para más información.

## 👨‍💻 Autor

**Juan Carlos Lumbiarres** - [@jclumbiarres](https://github.com/jclumbiarres)

Proyecto Link: [https://github.com/jclumbiarres/ffime](https://github.com/jclumbiarres/ffime)
