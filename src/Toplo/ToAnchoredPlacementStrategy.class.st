Class {
	#name : #ToAnchoredPlacementStrategy,
	#superclass : #ToPlacementStrategy,
	#category : #'Toplo-Widget-Window'
}

{ #category : #'opening-closing' }
ToAnchoredPlacementStrategy >> check: aWindow beforePopupIn: aWidget [

	| gap |
	" layout is done, aWindow bounds are now up-to-date"
	
	" check if aWindow position is ok according to aWidget "
	gap := aWidget margin topLeft + aWidget padding topLeft.
	aWindow relocate: aWindow position + gap.
	super check: aWindow beforePopupIn: aWidget
]

{ #category : #'opening-closing' }
ToAnchoredPlacementStrategy >> popup: aWindow [

	| spaceLayer |
	aWindow relocate: (aWindow anchor bounds inSpace bounds topLeft).
	"I'm not ready to be visible because my bounds are not checked according to the popup layer extent"
	aWindow visibility: BlVisibility hidden.
	spaceLayer := aWindow anchor space overlayLayer.
	spaceLayer addChild: aWindow.
	
	"I need to finalize my position as soon as my layout is up-to-date"
	aWindow whenLayoutedDoOnce: [ self check: aWindow beforePopupIn: spaceLayer ].

	

]
