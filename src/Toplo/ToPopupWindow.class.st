Class {
	#name : #ToPopupWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'#widget => ObservableSlot',
		'#widgetPositionHandler'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'initialize-release' }
ToPopupWindow >> close [

	self widget ifNotNil: [ :w |
		w dispatchEvent: (ToPopupWindowClosedEvent new
				 window: self;
				 yourself).
		self uninstalledFromWidget: w ].
	^ super close
]

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
ToPopupWindow >> installedInWidget: aWidget [

	widgetPositionHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ :event | self close ].
	widget addEventHandler: widgetPositionHandler
]

{ #category : #initialization }
ToPopupWindow >> openPositionFromEvent: anEvent [

	^ self widget bounds inSpace bounds bottomLeft
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupEvent: anEvent [

	self cleanUp.
	self widget ifNotNil: [ :w |
		w dispatchEvent: (ToPopupWindowOpenedEvent new
				 window: self;
				 sourceEvent: anEvent;
				 yourself) ].
	self placementStrategy popup: self event: anEvent
]

{ #category : #initialization }
ToPopupWindow >> uninstalledFromWidget: aWidget [

	aWidget ifNil: [ ^ self ].
	aWidget removeEventHandler: widgetPositionHandler.
	widgetPositionHandler := nil
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

	widget := aWidget
]
