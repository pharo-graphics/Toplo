Class {
	#name : #ToWidgetPlacementStrategyWithAction,
	#superclass : #ToPlacementStrategy,
	#instVars : [
		'placementAction'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'opening-closing' }
ToWidgetPlacementStrategyWithAction >> check: aWindow beforePopupIn: aWidget [

	| gap rect |
	" layout is done, aWindow bounds are now up-to-date"
	" check if aWindow position is ok according to aWindow extent and the space extent"
	rect := aWindow bounds inSpace asRectangle.
	gap := rect amountToTranslateWithin: (0 asPoint extent: aWindow space extent).
	aWindow relocate: aWindow position + gap.
	" aWindow bounds are up-to-date, I can be visible "
	super check: aWindow beforePopupIn: aWidget

]

{ #category : #initialization }
ToWidgetPlacementStrategyWithAction >> initialize [ 

	super initialize.
	placementAction := [ :window :event | window relocate: (window widget bounds inSpace bounds bottomLeft)]
]

{ #category : #accessing }
ToWidgetPlacementStrategyWithAction >> placementAction [

	^ placementAction
]

{ #category : #accessing }
ToWidgetPlacementStrategyWithAction >> placementAction: aBlock [

	" aBlock takes the window and anEvent as arguments, returns the position"
	placementAction := aBlock
]

{ #category : #'opening-closing' }
ToWidgetPlacementStrategyWithAction >> popup: aWindow [
	
	self popup: aWindow event: nil
]

{ #category : #'opening-closing' }
ToWidgetPlacementStrategyWithAction >> popup: aWindow event: anEvent [

	self placementAction value: aWindow value: anEvent.
	"I'm not ready to be visible because my bounds are not checked according to the popup layer extent"
	aWindow visibility: BlVisibility hidden.
	aWindow widget space popupLayer addChild: aWindow.

	"I need to finalize my position as soon as my layout is up-to-date"
	aWindow whenLayoutedDoOnce: [ self check: aWindow beforePopupIn: aWindow widget space popupLayer ]
]
