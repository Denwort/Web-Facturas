% include('_header_edit_new.tpl')

<body>

  <h1>Editar la Compra {{id}}</h1>
  <form action="/compras/save" method="post">
    <input type="hidden" name="id" value="{{compras[0]}}"><br>
    <table>

      <tr>
        <td>Proveedor:</td>
        <td>
        <select name="proveedor_id">
          % for s in proveedores:
            % if compras[3] == s[0]:
              <option selected value="{{s[0]}}">{{s[1]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[1]}}</option>
            % end
          % end
        </select>
        </td>
      </tr>
      <tr>

      <tr>
        <td>Venta asociada:</td>
        <td>
        <select name="venta_id">
          % for s in ventas:
            % if compras[2] == s[0]:
              <option selected value="{{s[0]}}">{{s[0]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[0]}}</option>
            % end
          % end
        </select>
        </td>
      </tr>

      <tr>
        <td>Factura asociada:</td>
        <td>
        <select name="factura_id">
          % for s in facturas:
            % if compras[1] == s[0]:
              <option selected value="{{s[0]}}">{{s[0]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[0]}}</option>
            % end
          % end
        </select>
        </td>
      </tr>
      
        <td></td>
        <td>
          <button class="btn">Guardar Cambios</button>
        </td>
      </tr>
    </table>

  </form>
  
  <a href="/compras" class="btn">Cancelar</a>

  % include('_footer.tpl')
</body>
</html>