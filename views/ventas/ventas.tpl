<title>Lista de Ventas</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

<body>

  % include('_menu.tpl')

  <h1>Listado de Ventas</h1>

  <p>{{mensaje}}</p>
  <table>
    <thead>
      <th>Id</th>
      <th>Cliente</th>
      <th>Fecha</th>
      <th>Monto</th>
      <th>Moneda</th>
    </thead>
    <tbody>
      % for s in contenido:
      <tr>
        <td>{{s[0]}}</td>
        <td>{{s[1]}}</td>
        <td>{{s[2]}}</td>
        <td>{{s[3]}}</td>
        <td>{{s[4]}}</td>
        <td>
          <a href="/ventas/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/ventas/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>

  % include('_footer.tpl')
</body>
</html>