% include('_header_edit_new.tpl')


<body>
  <h1>Crear Moneda</h1>
  <form action="/monedas/save" method="post">
    <input type="hidden" name="id" value="{{contenido[0]}}"><br>
    <table>
      <tr>
        <td>Nombre:</td>
        <td><input type="text" id="id" name="nombre" value="{{contenido[1]}}"></td>
      </tr>
        <td></td>
        <td>
          <button class="btn">Guardar Cambios</button>
        </td>
      </tr>
    </table>
  </form>

  <br><a href="/monedas" class="btn">Cancelar</a><br><br>
  % include('_footer.tpl')
</body>
</html>