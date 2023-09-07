<html>

% include('_style_menu.tpl')
  <style>
    .blocked {
      pointer-events: none;
      animation: blink 13.4s infinite;
    }
    
    @keyframes blink {
      0% { opacity: 0; }
      50% { opacity: 0; }
      55% { opacity: 0.05; }
      57.5% { opacity: 0.1; }
      60% { opacity: 0.15; }
      75% { opacity: 0.7; }
      97% { opacity: 0.1; }
      100% { opacity: 0; }
    }
  </style>

<body>
  % include('_menu.tpl')


  <div class="tenor-gif-embed blocked" data-postid="24397066" data-share-method="host" data-aspect-ratio="1.049" data-width="10%">
    <a href="https://tenor.com/view/scream-gif-24397066">Scream GIF</a>
  </div>
  <script type="text/javascript" async src="https://tenor.com/embed.js"></script>




  % include('_footer.tpl')
</body>
</html>
