Class {
	#name : #ToPopupWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'#widget => ObservableSlot'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'t - initialization dresser' }
ToPopupWindow >> defaultDresser [ 

	^ ToPopupWindowDresser new
]

{ #category : #initialization }
ToPopupWindow >> defaultPlacementStrategy [

	^ ToPopupPlacementStrategy new
]

{ #category : #initialization }
ToPopupWindow >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeDresser
]

{ #category : #initialization }
ToPopupWindow >> openPositionFromEvent: anEvent [

	^ self widget bounds inSpace bounds bottomLeft
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
