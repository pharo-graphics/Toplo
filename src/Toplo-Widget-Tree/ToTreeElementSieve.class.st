Class {
	#name : #ToTreeElementSieve,
	#superclass : #ToListElementSieve,
	#category : #'Toplo-Widget-Tree-Sieve'
}

{ #category : #accessing }
ToTreeElementSieve >> dataFilter: aValuable [
	" filter takes a wrapped data and a pattern as argument "

	super dataFilter: [ :item :pattern |
		item isRoot and: [ aValuable value: item unwrapped value: pattern ] ]
]
