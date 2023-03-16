Class {
	#name : #ToPopupPlacementStrategy,
	#superclass : #ToPlacementStrategy,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToPopupPlacementStrategy >> action [

	^ action
]

{ #category : #accessing }
ToPopupPlacementStrategy >> action: aBlock [

	" aBlock takes the window and anEvent as arguments, returns the position"
	action := aBlock
]

{ #category : #'opening-closing' }
ToPopupPlacementStrategy >> check: aWindow beforePopupIn: aWidget [

	| gap rect |
	" layout is done, aWindow bounds are now up-to-date"
	" check if aWindow position is ok according to aWindow extent and the space extent"
	rect := aWindow bounds inSpace asRectangle.
	gap := rect amountToTranslateWithin: (0 asPoint extent: aWindow space extent).
	aWindow relocate: aWindow position + gap.
	super check: aWindow beforePopupIn: aWidget

]

{ #category : #initialization }
ToPopupPlacementStrategy >> defaultAction [

	^ [ :window :event | window relocate: (window openPositionFromEvent: event)]
]

{ #category : #initialization }
ToPopupPlacementStrategy >> initialize [ 

	super initialize.
	action := self defaultAction
]

{ #category : #'opening-closing' }
ToPopupPlacementStrategy >> popup: aWindow [
	
	self popup: aWindow event: nil
]

{ #category : #'opening-closing' }
ToPopupPlacementStrategy >> popup: aWindow event: anEvent [

	self action value: aWindow value: anEvent.
	"I'm not ready to be visible because my bounds are not checked according to the popup layer extent"
	aWindow visibility: BlVisibility hidden.
	aWindow widget space popupLayer addChild: aWindow.

	"I need to finalize my position as soon as my layout is up-to-date"
	aWindow whenLayoutedDoOnce: [ self check: aWindow beforePopupIn: aWindow widget space popupLayer ]
]
