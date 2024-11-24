channel.of(1,2,3,1,2,3,2)
     .collate(2)
     .view()

channel.of(5,6,56,3,4,3,4,3)
     .collate(2, false)
     .view()


channel.of(11,22,33,44,55,66,77,88)
     .collate(2, 1)
     .view()