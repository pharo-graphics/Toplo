Class {
	#name : #ToWrappedListElementSieve,
	#superclass : #ToListElementSieve,
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #accessing }
ToWrappedListElementSieve >> filter: aValuable [
	" filter takes a wrapped data and a pattern as argument "

	super filter: [ :item :pattern |
		aValuable value: item unwrappedDataItem value: pattern ]
]

{ #category : #accessing }
ToWrappedListElementSieve >> pattern: aPattern [

	" simple collapse all roots because by default, 
	this implementation don't manage a filter result with expanded nodes "
	originalData mirrored roots reverseDo: [ :w | w collapse ].
	super pattern: aPattern
]
