Class {
	#name : #ToOverlayedPlacementStrategy,
	#superclass : #ToPlacementStrategy,
	#category : #'Toplo-Widget-Window'
}

{ #category : #'opening-closing' }
ToOverlayedPlacementStrategy >> check: aWindow beforePopupIn: aWidget [

	" aWindow bounds are up-to-date, I can be visible "
	aWindow size: aWindow overlayed size.
	super check: aWindow beforePopupIn: aWidget
]

{ #category : #'opening-closing' }
ToOverlayedPlacementStrategy >> popup: aWindow event: anEvent [

	| spaceLayer |
	aWindow position: aWindow bounds inSpace bounds topLeft.
	"I'm not ready to be visible because my bounds are not checked according to the popup layer extent"
	aWindow visibility: BlVisibility hidden.
	spaceLayer := aWindow overlayed space overlayLayer.
	spaceLayer addChild: aWindow.

	"I need to finalize my position as soon as my layout is up-to-date"
	aWindow whenLayoutedDoOnce: [
		self check: aWindow beforePopupIn: spaceLayer ]
]
