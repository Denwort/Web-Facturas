<title>Lista de Productos</title>

% include('_style_menu.tpl')

% include('_header_entity.tpl')

  <style>
    .hidden {
      display: none;
    }
  </style>

<body>

  % include('_menu.tpl')

  <h1>Listado de Facturas</h1>

  <p>{{mensaje}}</p>
  <a href="/facturas/new" class="btn">Agregar Registro</a><br><br>
  <table>
    <thead>
      <th><u>Id</u></th>
      <th><u>Transaccion</u></th>
      <th><u>Razon social</u></th>
      <th><u>Fecha</u></th>
      <th><u>Valor</u></th>
      <th><u>IGV</u></th>
      <th><u>Precio</u></th>
      <th><u>Moneda</u></th>
      <th><u>Acciones</u></th>
    </thead>
    <tbody>
      % i = 0
      % for s in contenido:
      <tr>
        <td><b>{{s[0]}}</b></td>
        <td><b>{{s[1]}}</b></td>
        <td><b>{{s[2]}}</b></td>
        <td><b>{{s[3]}}</b></td>
        <td><b>{{round(s[4],2)}}</b></td>
        <td><b>{{round(s[5],2)}}</b></td>
        <td><b>{{round(s[6],2)}}</b></td>
        <td><b>{{s[7]}}</td>
        <td>
          <a href="/detalles/new?factura_id={{s[0]}}" class="btn">Agregar producto</a>
          <a href="/facturas/edit?id={{s[0]}}" class="btn">Editar</a>
          <a href="/facturas/delete?id={{s[0]}}" class="btn">Eliminar</a>
        </td>
      </tr>

        % j = 0

        % for p in detalles[i]:

          % if j == 0:
            <tr>
              <td></td>
              <td><u></u></td>
              <td><u>Producto</u></td>
              <td><u>Cantidad</u></td>
              <td><u>Valor</u></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
          % end
          % j = j+1

          <tr>
            <td></td>
            <td></td>
            <td>{{p[1]}}</td>
            <td>{{p[2]}}</td>
            <td>{{p[3]}}</td>
            <td></td>
            <td></td>
            <td></td>
            <td>
              <a href="/detalles/edit?id={{p[0]}}">Editar</a>
              <a href="/detalles/delete?id={{p[0]}}">Eliminar</a>
            </td>
          </tr>
        % end

        % i = i+1

      % end

    </tbody>
  </table>
  % include('_footer.tpl')

</body>
</html>