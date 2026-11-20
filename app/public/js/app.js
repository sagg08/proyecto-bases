/**
 * app/public/js/app.js · Mejoras progresivas. La app funciona sin JavaScript;
 * esto solo agrega comodidades.
 */
document.addEventListener('DOMContentLoaded', () => {
  // 1. Al enviar un formulario: botón en estado "cargando" para evitar doble envío
  document.querySelectorAll('form').forEach((form) => {
    form.addEventListener('submit', () => {
      const boton = form.querySelector('button[type="submit"]');
      if (boton) boton.setAttribute('aria-busy', 'true');
    });
  });

  // 2. Si el servidor devolvió errores, llevar el foco al primer campo inválido
  const primerInvalido = document.querySelector('[aria-invalid="true"]');
  if (primerInvalido) primerInvalido.focus();

  // 3. Teléfonos (multivaluado): agregar otro input igual al último
  document.querySelectorAll('[data-agregar-telefono]').forEach((boton) => {
    const lista = boton.closest('.campo').querySelector('[data-telefonos]');
    boton.addEventListener('click', () => {
      const inputs = lista.querySelectorAll('input');
      if (inputs.length >= 5) return;                     // mismo límite que la validación
      const nuevo = inputs[inputs.length - 1].cloneNode();
      nuevo.value = '';
      nuevo.removeAttribute('aria-invalid');
      nuevo.removeAttribute('aria-describedby');
      nuevo.setAttribute('aria-label', `Teléfono ${inputs.length + 1}`);
      lista.appendChild(nuevo);
      nuevo.focus();
      if (inputs.length + 1 >= 5) boton.disabled = true;
    });
  });
});
