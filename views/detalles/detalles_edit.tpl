% include('_header_edit_new.tpl')

<body onload="actualizarValorUnitario()">

  <h1>Editar un Detalle {{id}}</h1>
  <form action="/detalles/save" method="post">
    <input type="hidden" name="id" value="{{contenido[0]}}"><br>
    <table>
      <tr>
        <td>Factura asociada:</td>
        <td>
          <select name="factura_id" id="factura_id"
          % if factura_id!=0 :
          disabled
          % end
          >
            <option value="">Seleccione una opción</option>
            % for s in facturas:
              % if s[0] == contenido[3]:
                <option selected value="{{s[0]}}">{{s[0]}}</option>
              % else:
                <option value="{{s[0]}}">{{s[0]}}</option>
              % end
            % end
        </select>
        </td>
      </tr>
      <tr>
        <td>Cantidad:</td>
        <td><input type="number" id="cantidad" name="cantidad" onChange="actualizarValorTotal()" value="{{contenido[1]}}"></td>
      </tr>
      <tr>
        <td>Producto:</td>
        <td>
        <select id="producto_id" name="producto_id" onChange="actualizarValorUnitario();actualizarValorTotal();">
          <option value="">Seleccione una opción</option>
          % for s in productos:
            % if s[0] == contenido[4]:
                <option selected value="{{s[0]}}" class="{{s[1]}}">{{s[4]}}</option>
              % else:
                <option value="{{s[0]}}" class="{{s[1]}}">{{s[4]}}</option>
              % end
          % end
        </select>
        </td>
      </tr>
      <tr>
        <td>Valor unitario:</td>
        <td><input type="number" id="valor_unitario" name="valor_unitario" step=0.01 onChange="actualizarValorTotal()" value=""></td>
      </tr>
      <tr>
        <td>Valor total:</td>
        <td><input type="numer" id="valor_total" name="valor_total" step=0.01 value="{{contenido[2]}}"></td>

      <tr>
        <td></td>
        <td>
          <button class="btn">Guardar Cambios</button>
        </td>
      </tr>
    </table>

    <script>
      function actualizarValorUnitario()
      {
        var e = document.getElementById('producto_id')
        var costo_unitario = e.options[e.selectedIndex].className
        document.getElementById('valor_unitario').value = costo_unitario
      }

      function actualizarValorTotal()
      {
        var str_cantidad = document.getElementById('cantidad').value
        var str_valor_unitario = document.getElementById('valor_unitario').value
        var cantidad = parseFloat(str_cantidad)
        var valor_unitario = parseFloat(str_valor_unitario)
        document.getElementById('valor_total').value = parseFloat((cantidad * valor_unitario).toFixed(2))
      }

      document.querySelector("form").addEventListener("submit", function(e){
              document.getElementById('factura_id').removeAttribute("disabled");
          });

    </script>
  </form>

  <a href="/facturas" class="btn">Cancelar</a>
  % include('_footer.tpl')
</body>
</html>