<title>Lista de Clientes</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

<body>

  % include('_menu.tpl')

  <h1>Listado de Clientes</h1>

  <p>{{mensaje}}</p>
  <a href="/clientes/new" class="btn"> Agregar Registro </a><br><br>
  <table>
    <thead>
      <th>Id</th>
      <th>RUC</th>
      <th>Razon Social</th>
      <th>Dirección de la Empresa</th>
      <th>Acciones</th>
    </thead>
    <tbody>
      % for s in contenido:
      <tr>
        <td>{{s[0]}}</td>
        <td>{{s[1]}}</td>
        <td>{{s[2]}}</td>
        <td>{{s[3]}}</td>
        <td>
          <a href="/clientes/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/clientes/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>
  % include('_footer.tpl')
</body>
</html>