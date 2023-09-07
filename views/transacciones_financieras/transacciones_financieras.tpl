<title>Lista de Transacciones Financieras</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

<body>

  % include('_menu.tpl')

  <h1>Listado de Transacciones Financieras</h1>

  <p>{{mensaje}}</p>
  <a href="/transacciones_financieras/new" class="btn">Agregar Registro</a><br><br>
  <table>
    <thead>
      <th>Id</th>
      <th>Fecha</th>
      <th>Monto</th>
      <th>Factura asociada</th>
      <th>Forma de pago</th>
      <th>Empleado</th>
      <th>Acciones</th>
    </thead>
    <tbody>
      % for s in contenido:
      <tr>
        <td>{{s[0]}}</td>
        <td>{{s[1]}}</td>
        <td>{{s[2]}}</td>
        <td>{{s[3]}}</td>
        <td>{{s[5]}}</td>
        <td>{{s[4]}}</td>
        <td>
          <a href="/transacciones_financieras/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/transacciones_financieras/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>

  % include('_footer.tpl')
</body>
</html>