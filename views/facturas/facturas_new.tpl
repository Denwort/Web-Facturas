% include('_header_edit_new.tpl')

<body>

  <h1>Crear una Factura {{id}}</h1>
  <form action="/facturas/save" method="post">
    <input type="hidden" name="id" value="{{facturas[0]}}"><br>
    <table>
      <tr>
        <td>Valor Venta:</td>
        <td><input type="number" step="0.01" id="id" name="valor_venta" value="{{facturas[1]}}"></td>
      </tr>

      <tr>
        <td>Moneda:</td>
        <td>
        <select id="opcionSelect2" onchange="actualizarValor2()">
          <option value="">Seleccione una opción</option>
          % for s in monedas:
            % if facturas[6] == s[0]:
              <option selected value="{{s[0]}}">{{s[1]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[1]}}</option>
            % end
          % end
        </select>
        </td>
        <input type="hidden" id="valorInput2" name="moneda_id" value="{{facturas[6]}}"">
      </tr>

      <tr>
        <td>Fecha Creación:</td>
        <td><input type="date" id="id" name="fecha_creacion" value="{{facturas[4]}}"></td>
      </tr>

      <tr>
        <td>Transaccion:</td>
        <td>
        <select id="transaccion" name="transaccion" onChange="cambiarTransaccion();">
          <option value="">Seleccione una opción</option>
          <option value="V">Venta</option>
          <option value="C">Compra</option>
        </select>
        </td>
      </tr>

      <tr id="trcliente">
        <td>Cliente:</td>
        <td>
        <select name="cliente_id">
          <option selected value="0">Seleccione una opción</option>
          % for s in clientes:
            <option value="{{s[0]}}">{{s[1]}} - {{s[2]}}</option>
          % end
        </select>
        </td>
      </tr>

      <tr id="trproveedor">
        <td>Proveedor:</td>
        <td>
        <select name="proveedor_id">
          <option selected value="0">Seleccione una opción</option>
          % for s in proveedores:
            <option value="{{s[0]}}">{{s[1]}} - {{s[2]}}</option>
          % end
        </select>
        </td>
      </tr>

      <tr id="trventa">
        <td>Venta asociada:</td>
        <td>
        <select name="venta_id">
          <option selected value="0">Seleccione una opción</option>
          % for s in ventas:
            <option value="{{s[0]}}">{{s[1]}} - {{s[2]}}</option>
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

    <script>

      function actualizarValor2() {
        var selectElement = document.getElementById("opcionSelect2");
        var selectedValue = selectElement.value;
  
        var valorInput = document.getElementById("valorInput2");
        valorInput.value = selectedValue;
      }

      document.getElementById('trcliente').style.display = 'none';
      document.getElementById('trproveedor').style.display = 'none';
      document.getElementById('trventa').style.display = 'none';

      function cambiarTransaccion()
      {
        if (document.getElementById('transaccion').value == "V")
        {
          console.log("venta")
          document.getElementById('trcliente').style.display = 'table-row';
          document.getElementById('trproveedor').style.display = 'none';
          document.getElementById('trventa').style.display = 'none';
        }
        else if (document.getElementById('transaccion').value == "C")
        {
          console.log("compra")
          document.getElementById('trcliente').style.display = 'none';
          document.getElementById('trproveedor').style.display = 'table-row';
          document.getElementById('trventa').style.display = 'table-row';
        }
      }

      
      
    </script>
  </form>

  <a href="/facturas" class="btn">Cancelar</a>

  % include('_footer.tpl')
</body>
</html>