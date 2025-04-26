Class {
	#name : #ToMenuContainerOpeningStartStep,
	#superclass : #ToAnchoredWindowOpeningStartStep,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #running }
ToMenuContainerOpeningStartStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [
	" if there is not enough place then turn as a scrollable menu container "

	| height |
	height := aWindow padding height.
	aWindow itemBar nodesDo: [ :node |
		height := height + node measuredHeight ].
	aWindow anchorRoot height <= height
		ifTrue: [
			aWindow vMatchParent.
			aWindow isScrollable: true ]
		ifFalse: [
			aWindow vFitContent.
			aWindow isScrollable: false ].
	^ super
		  nextStepFor: aWindow
		  onEvent: anEvent
		  onLayout: aBounds
		  context: aBlElementBoundsUpdateContext
]
