Class {
	#name : #ToTreeElementSieve,
	#superclass : #ToListElementSieve,
	#category : #'Toplo-Widget-Tree-Sieve'
}

{ #category : #accessing }
ToTreeElementSieve >> filter: aValuable [
	" filter takes a wrapped data and a pattern as argument "

	super filter: [ :item :pattern |
		aValuable value: item unwrappedDataItem value: pattern ]
]

{ #category : #accessing }
ToTreeElementSieve >> pattern: aPattern [

	" simple collapse all roots because by default, 
	this implementation don't manage a filter result with expanded nodes "
	originalData mirrored roots reverseDo: [ :w | w collapse ].
	super pattern: aPattern
]
