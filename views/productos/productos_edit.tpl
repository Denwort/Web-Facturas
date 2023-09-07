% include('_header_edit_new.tpl')

<body>

  <h1>Editar una Producto {{id}}</h1>
  <form action="/productos/save" method="post">
    <input type="hidden" name="id" value="{{productos[0]}}"><br>
    <table>
      <tr>
        <td>Nombre:</td>
        <td><input type="text" id="id" name="nombre" value="{{productos[3]}}"></td>
      </tr>
      <tr>
        <td>Valor Unitario:</td>
        <td><input type="number" id="id" name="valor_unitario" value="{{productos[1]}}"></td>
      </tr>
      <tr>
        <td>Codigo:</td>
        <td><input type="text" id="id" name="codigo" value="{{productos[4]}}"></td>
      </tr>
      <tr>
        <td>Informacion Adicional:</td>
        <td><input type="text" id="id" name="informacion_adicional" value="{{productos[2]}}"></td>
      </tr>

      <tr>
        <td>Tipo Producto:</td>
        <td>
        <select id="opcionSelect1" onchange="actualizarValor1()">
          % for s in tipos_producto:
            % if productos[5] == s[0]:
              <option selected value="{{s[0]}}">{{s[1]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[1]}}</option>
            % end
          % end
        </select>
        </td>
        <input type="hidden" id="valorInput1" name="tipo_producto_id" value="{{productos[5]}}">
      </tr>

      <tr>
        <td>Categoria:</td>
        <td>
        <select id="opcionSelect2" onchange="actualizarValor2()">
          % for s in categorias:
            % if productos[6] == s[0]:
              <option selected value="{{s[0]}}">{{s[1]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[1]}}</option>
            % end
          % end
        </select>
        </td>
        <input type="hidden" id="valorInput2" name="categoria_id" value="{{productos[6]}}">
      </tr>

      <tr>
        <td>Unidad Medida:</td>
        <td>
        <select id="opcionSelect3" onchange="actualizarValor3()">
          % for s in unidades_medida:
            % if productos[7] == s[0]:
              <option selected value="{{s[0]}}">{{s[1]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[1]}}</option>
            % end
          % end
        </select>
        </td>
        <input type="hidden" id="valorInput3" name="unidad_medida_id" value="{{productos[7]}}">
      </tr>

      <tr>
        <td></td>
        <td>
          <button class="btn">Guardar Cambios</button>
        </td>
      </tr>
    </table>

    <script>
      function actualizarValor1() {
        var selectElement = document.getElementById("opcionSelect1");
        var selectedValue = selectElement.value;
  
        var valorInput = document.getElementById("valorInput1");
        valorInput.value = selectedValue;
      }
      function actualizarValor2() {
        var selectElement = document.getElementById("opcionSelect2");
        var selectedValue = selectElement.value;
  
        var valorInput = document.getElementById("valorInput2");
        valorInput.value = selectedValue;
      }
      function actualizarValor3() {
        var selectElement = document.getElementById("opcionSelect3");
        var selectedValue = selectElement.value;
  
        var valorInput = document.getElementById("valorInput3");
        valorInput.value = selectedValue;
      }
    </script>

  </form>
  <a href="/productos" class="btn">Cancelar</a>
  % include('_footer.tpl')
</body>
</html>