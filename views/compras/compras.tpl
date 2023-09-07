<title>Lista de Compras</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

<body>

  % include('_menu.tpl')

  <h1>Listado de Compras</h1>

  <p>{{mensaje}}</p>
  <table>
    <thead>
      <th>Id</th>
      <th>Proveedor</th>
      <th>Fecha</th>
      <th>Venta asociada</th>
      <th>Monto</th>
      <th>Moneda</th>
      <th>Acciones</th>
    </thead>
    <tbody>
      % for s in contenido:
      <tr>
        <td>{{s[0]}}</td>
        <td>{{s[1]}}</td>
        <td>{{s[2]}}</td>
        <td>{{s[3]}} - {{s[4]}}</td>
        <td>{{s[5]}}</td>
        <td>{{s[6]}}</td>
        <td>
          <a href="/compras/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/compras/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>

  % include('_footer.tpl')
</body>
</html>