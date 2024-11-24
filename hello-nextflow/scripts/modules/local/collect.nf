channel.of(1,2,3,4)
     .collect()
     .view()

channel.of('hallo', 'ciao', 'bonjour', 'namaste')
      .collect { it.length() }
      .view()