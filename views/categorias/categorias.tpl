<title>Lista de Categorias</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

<body>

  % include('_menu.tpl')

  <h1>Listado de Categorias</h1>

  <p>{{mensaje}}</p>
  <a href="/categorias/new" class="btn">Agregar Registro</a><br><br>
  <table>
    <thead>
      <th>Id</th>
      <th>Nombre</th>
      <th>Acciones</th>
    </thead>
    <tbody>
      % for s in contenido:
      <tr>
        <td>{{s[0]}}</td>
        <td>{{s[1]}}</td>
        <td>
          <a href="/categorias/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/categorias/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>
  % include('_footer.tpl')
</body>
</html>