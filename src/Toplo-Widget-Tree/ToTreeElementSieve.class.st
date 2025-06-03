Class {
	#name : #ToTreeElementSieve,
	#superclass : #ToListElementSieve,
	#category : #'Toplo-Widget-Tree-Sieve'
}

{ #category : #accessing }
ToTreeElementSieve >> dataFilter: aValuable [
	" filter takes a wrapped data and a pattern as argument "

	super dataFilter: [ :item :pattern |
		aValuable value: item unwrapped value: pattern ]
]

{ #category : #'api - hooks' }
ToTreeElementSieve >> newSievedListDataSourceEventHandler [

	^ ToSievedTreeDataSourceEventHandler new
]

{ #category : #'api - hooks' }
ToTreeElementSieve >> newSievedListElementEventHandler [

	^ ToSievedTreeElementEventHandler new
]

{ #category : #accessing }
ToTreeElementSieve >> pattern: aPattern [

	originalData mirrored rootsDo: [ :w | w collapse ].
	super pattern: aPattern
]
