channel.of(1,20,666)
    .branch {
        small: it < 10
              return it+2

        large: it < 50
             return it-2
        
        other: true
             return 0
    }
    .set { result }

result.small.view { "$it is small" }
result.large.view { "$it is large" }
result.other.view { "$it is other" }

def criteria = branchCriteria {
    small: it < 10
    large: it > 10
}

channel.of(1,15).branch(criteria).set{ch1}
channel.of(4,17).branch(criteria).set{ch2}

ch1.small.view { "$it is small" }
ch1.large.view { "$it is large" }
ch2.small.view { "$it is small" }
ch2.large.view { "$it is large" }
