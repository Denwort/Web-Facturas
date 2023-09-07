% include('_header_edit_new.tpl')

<body>

  <h1>Crear una Transaccion Financiera {{id}}</h1>
  <form action="/transacciones_financieras/save" method="post">
    <input type="hidden" name="id" value="{{contenido[0]}}"><br>
    <table>
      <tr>
        <td>Monto:</td>
        <td><input type="text" name="monto" value="{{contenido[2]}}"></td>
      </tr>
      <tr>
        <td>Fecha:</td>
        <td><input type="date" name="fecha" value="{{contenido[1]}}"></td>
      </tr>
      
      <tr>
        <td>Factura asociada:</td>
        <td>
        <select name="factura_id">
          <option value="">Seleccione una opción</option>
          % for s in facturas:
            <option value="{{s[0]}}">{{s[0]}}</option>
          % end
        </select>
        </td>
      </tr>

      <tr>
        <td>Forma de pago:</td>
        <td>
        <select name="forma_pago_id">
          <option value="">Seleccione una opción</option>
          % for s in formas_pago:
            <option value="{{s[0]}}">{{s[1]}}</option>
          % end
        </select>
        </td>
      </tr>

      <tr>
        <td>Empleado:</td>
        <td>
        <select name="empleado_id">
          <option value="">Seleccione una opción</option>
          % for s in empleados:
            <option value="{{s[0]}}">{{s[1]}}</option>
          % end
        </select>
        </td>
      </tr>      

      <tr>
        <td></td>
        <td>
          <button class="btn">Guardar Cambios</button>
        </td>
      </tr>
    </table>

  </form>

  <a href="/productos" class="btn">Cancelar</a>
  % include('_footer.tpl')
</body>
</html>