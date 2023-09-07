<title>Lista de Detalles</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

<body>

  % include('_menu.tpl')

  <h1>Listado de Detalles</h1>

  <p>{{mensaje}}</p>
  <table>
    <thead>
      <th>Id</th>
      <th>Cantidad</th>
      <th>Producto</th>
      <th>Valor Total</th>
      <th>Factura asociada</th>
      <th>Acciones</th>
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
          <a href="/detalles/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/detalles/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>

  % include('_footer.tpl')
</body>
</html>