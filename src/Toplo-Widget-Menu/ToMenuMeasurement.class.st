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
	aWindow itemBar nodeContainersDo: [ :container |
		height := height + container measuredHeight ].
	(aWindow anchorRoot height "- pos y") <= height
		ifTrue: [
			aWindow vMatchParent. "height: (aWindow anchorRoot height - pos y)."
			aWindow isScrollable: true ]
		ifFalse: [
			aWindow vFitContent.
			aWindow isScrollable: false ]
]
