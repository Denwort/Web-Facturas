<title>Lista de Forma de Pago</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

<body>

  % include('_menu.tpl')

  <h1>Listado de Formas de Pago</h1>
  <p>{{mensaje}}</p>
  <a href="/formas_pago/new" class="btn">Agregar Registro</a><br><br>
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
          <a href="/formas_pago/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/formas_pago/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>
  % include('_footer.tpl')
</body>
</html>