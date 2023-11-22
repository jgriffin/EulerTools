import Algorithms

public func product3<Base1: Sequence, Base2: Collection, Base3: Collection>(
    _ s1: Base1, _ s2: Base2, _ s3: Base3
) ->
    [(Base1.Element, Base2.Element, Base3.Element)]
{
    product(s1, product(s2, s3))
        .map { t in (t.0, t.1.0, t.1.1) }
}

public func product4<Base1: Sequence, Base2: Collection, Base3: Collection, Base4: Collection>(
    _ s1: Base1, _ s2: Base2, _ s3: Base3, _ s4: Base4
) ->
    [(Base1.Element, Base2.Element, Base3.Element, Base4.Element)]
{
    product(s1, product(s2, product(s3, s4)))
        .map { t in (t.0, t.1.0, t.1.1.0, t.1.1.1) }
}
