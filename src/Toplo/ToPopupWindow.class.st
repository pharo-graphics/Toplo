Class {
	#name : #ToPopupWindow,
	#superclass : #ToBasicAnimatedWindow,
	#instVars : [
		'#widget => ObservableSlot'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - displaying' }
ToPopupWindow >> checkBeforePopupIn: aWidget [

	| gap rect |
	" layout is done, my bounds are now up-to-date"
	" I have to check if my position is ok according to my extent and the space extent"
	rect := self bounds inSpace asRectangle.
	gap := rect amountToTranslateWithin: (0 asPoint extent: self space extent).
	self relocate: self position + gap.
	" my bounds are up-to-date, I can be visible "
	super checkBeforePopupIn: aWidget

"<kept for the record>
	"" layout is done, my bounds are now up-to-date""
	boundsInSpace := widget bounds inSpace bounds.
	(boundsInSpace closestEdgeTo: pointer) traceCr.
	proj := (boundsInSpace outsideNormalCloseTo: pointer).
	self relocate: proj point.
"
]

{ #category : #'t - initialization dresser' }
ToPopupWindow >> defaultDresser [ 

	^ ToPopupWindowDresser new
]

{ #category : #initialization }
ToPopupWindow >> defaultPlacementStrategy [

	^ ToWidgetPlacementStrategyWithAction new
]

{ #category : #initialization }
ToPopupWindow >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeDresser
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupEvent: anEvent [
	self cleanUp.
	self placementStrategy popup: self event: anEvent
]

{ #category : #'property change hook' }
ToPopupWindow >> whenWidgetChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #widget whenChangedDo: aBlock
]

{ #category : #accessing }
ToPopupWindow >> widget [

	^ widget 

]

{ #category : #accessing }
ToPopupWindow >> widget: aWidget [

	widget := aWidget.
	widget when: BlElementPositionInSpaceChangedEvent do: [ :event | 
		self relocate: self widget bounds inSpace bounds bottomLeft ]
]
