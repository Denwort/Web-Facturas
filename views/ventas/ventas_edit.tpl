% include('_header_edit_new.tpl')

<body>
  <h1>Editar una Venta {{ventas[0]}}</h1>
  <form action="/ventas/save" method="post">
    <input type="hidden" name="id" value="{{ventas[0]}}"><br>
    <table>
      <tr>
        <td>Cliente:</td>
        <td>
        <select name="cliente_id">
          % for s in clientes:
            % if ventas[1] == s[0]:
              <option selected value="{{s[0]}}">{{s[1]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[1]}}</option>
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
            % if ventas[2] == s[0]:
              <option selected value="{{s[0]}}">{{s[0]}}</option>
            % else:
              <option value="{{s[0]}}">{{s[0]}}</option>
            % end
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
  <a href="/" class="btn">Cancelar</a>
  % include('_footer.tpl')
</body>
</html>