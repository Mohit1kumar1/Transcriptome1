channel.of(1,45,5,16,6,2)
     .buffer { it==2 }
     .view()

channel.of(1,2,3,4,5,6,7,8,9)
     .buffer(3,8)
     .view()

channel.of(1,2,3,4,5,6,7,8,9)
     .buffer( size:2, remainder: true )
     .view()

channel.of(1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,56)
     .buffer(size:5, skip:1, remainder: true)
     .view()