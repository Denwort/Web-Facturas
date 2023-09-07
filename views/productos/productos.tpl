<title>Lista de Productos</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

<body>

  % include('_menu.tpl')

  <h1>Listado de Productos</h1>

  <p>{{mensaje}}</p>
  <a href="/productos/new" class="btn">Agregar Registro</a><br><br>
  <table>
    <thead>
      <th>Id</th>
      <th>Nombre</th>
      <th>Valor Unitaro</th>
      <th>Codigo</th>
      <th>Informacion Adicional</th>
      <th>Tipo Producto</th>
      <th>Categoria</th>
      <th>Unidad de Medida</th>
      <th>Acciones</th>
    </thead>
    <tbody>
      % for s in contenido:
      <tr>
        <td>{{s[0]}}</td>
        <td>{{s[1]}}</td>
        <td>{{round(s[2], 2)}}</td>
        <td>{{s[3]}}</td>
        <td>{{s[4]}}</td>
        <td>{{s[6]}}</td>
        <td>{{s[8]}}</td>
        <td>{{s[10]}}</td>
        <td>
          <a href="/productos/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/productos/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>
  % include('_footer.tpl')
</body>
</html>