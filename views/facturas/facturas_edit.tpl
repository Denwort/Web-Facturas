% include('_header_edit_new.tpl')

<body>

  <h1>Editar la Factura {{id}}</h1>
  <form action="/facturas/save" method="post">
    <input type="hidden" name="id" value="{{facturas[0]}}"><br>
    <table>
      <tr>
        <td>Valor Venta:</td>
        <td><input type="number" id="id" name="valor_venta" value="{{facturas[1]}}"></td>
      </tr>
      
      <tr>
        <td>Fecha Creación:</td>
        <td><input type="date" id="id" name="fecha_creacion" value="{{facturas[4]}}"></td>
      </tr>

      <tr>
        <td>Moneda:</td>
        <td>
        <select id="opcionSelect2" onchange="actualizarValor2()">
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
    </script>
  </form>
  
  <a href="/facturas" class="btn">Cancelar</a>

  % include('_footer.tpl')
</body>
</html>