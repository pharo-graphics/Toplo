Class {
	#name : #ToMenuMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #api }
ToMenuMeasurement >> onMeasure: anExtentMeasurementSpec element: aWindow onEvent: anEvent [

" if there is not enough place then turn as a scrollable menu container "

	| height pos |
	pos := aWindow measuredPosition.
	height := aWindow padding height + aWindow margin height.
	aWindow itemBar nodesDo: [ :node |
		height := height + node measuredHeight ].
	(aWindow anchorRoot height "- pos y") <= height
		ifTrue: [
			aWindow vMatchParent. "height: (aWindow anchorRoot height - pos y)."
			aWindow isScrollable: true ]
		ifFalse: [
			aWindow vFitContent.
			aWindow isScrollable: false ]
]
