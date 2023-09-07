<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
% include('_header.tpl')
<body>
  <a href="/"> Home </a>
  <h1>Lista de {{nombreTabla}}</h1>

  <table>
    <thead>
      % for cabeza in cabecera:
      <th>{{cabeza[1]}}</th>
      % end
      <th>Acciones</th>
    </thead>
    <tbody>
      % for columna in albumes:
      <tr>
        % for i in range(len(columna)):
        <td>{{columna[i]}}</td>
        % end
        <td>
          <a href="/artist/edit?id={{columna[0]}}">Editar</a>
          <a href="/artist/delete?id={{columna[0]}}">Eliminar</a>
        </td>
      </tr>
      % end
    </tbody>
  </table>
  % include('_footer.tpl')
</body>
</html>
