# Integración de Gemini-CLI en Neovim - Tareas Pendientes

## Resumen del Progreso

Hemos integrado con éxito `gemini-cli` en Neovim para proporcionar asistencia de desarrollo.

- **Funcionalidad Principal:** Se ha creado un módulo en `lua/utils/gemini.lua` que:
  - Captura texto de una selección visual en cualquier modo (`v`, `V`, `<C-v>`).
  - Pide un prompt al usuario a través de `vim.ui.input()`.
  - Ejecuta `gemini-cli` de forma asíncrona.
  - Muestra la salida en una ventana flotante.

- **Atajo de Teclado:** Se ha configurado el atajo `<leader>ga` en `lua/config/keymaps.lua` para ejecutar la funcionalidad. El atajo sale del modo visual primero para asegurar que la selección se capture correctamente.

## Siguiente Paso: Problema Pendiente

**Problema:** Cuando el texto seleccionado contiene caracteres especiales para el shell (como comillas dobles `"` o simples `'`), el comando que se pasa al terminal se rompe, causando un error.

**Solución Propuesta:** Modificar la función `ask_gemini` en `lua/utils/gemini.lua` para que utilice `vim.fn.shellescape()` en el `prompt` y en la `selection` antes de construir el comando final. Esto asegurará que todos los caracteres especiales se traten como texto literal y no rompan el comando del shell.
