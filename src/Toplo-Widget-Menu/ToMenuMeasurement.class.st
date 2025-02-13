Class {
	#name : #ToMenuMeasurement,
	#superclass : #ToWindowMeasurement,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #api }
ToMenuMeasurement >> onMeasure: anExtentMeasurementSpec window: aWindow onEvent: anEvent [

"	| w |
	w := 0.
	aWindow collectedNodesDo: [ :node | w := w max: node measuredWidth ].
	aWindow measuredWidth - aWindow padding width < w ifFalse: [ ^ self ].
	aWindow measuredExtent:
		w + aWindow padding width @ aWindow measuredHeight"
]
