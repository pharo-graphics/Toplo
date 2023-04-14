Class {
	#name : #ToPopupWindow,
	#superclass : #ToBasicWindowElement,
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - displaying' }
ToPopupWindow >> checkBeforePopupIn: aWidget [

	| gap rect |
	" layout is done, aWindow bounds are now up-to-date"" check if aWindow position is ok according to aWindow extent and the space extent"
	rect := self bounds inSpace asRectangle.
	gap := rect amountToTranslateWithin: (0 asPoint extent: self space extent).
	self position: self position + gap.
	super checkBeforePopupIn: aWidget
]

{ #category : #'api - displaying' }
ToPopupWindow >> close [

	self widget ifNotNil: [ :w |
		w dispatchEvent: (ToPopupWindowClosedEvent new
				 window: self;
				 yourself) ].
	^ super close
]

{ #category : #'t - initialization dresser' }
ToPopupWindow >> defaultDresser [ 

	^ ToPopupWindowDresser new
]

{ #category : #initialization }
ToPopupWindow >> defaultHook [

	^ [ :window :event |  window widget bounds inSpace bounds bottomLeft ]
]

{ #category : #initialization }
ToPopupWindow >> initialize [

	super initialize.
	self initializeDresser
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupEvent: anEvent [

	self cleanUp.
	self widget ifNotNil: [ :w |
		w dispatchEvent: (ToPopupWindowOpenedEvent new
				 window: self;
				 sourceEvent: anEvent;
				 yourself) ].
			
	super popupEvent: anEvent
]

{ #category : #'api - displaying' }
ToPopupWindow >> spaceLayer [ 

	^ self widget space popupLayer.

]
