Class {
	#name : #ToPopupWindow,
	#superclass : #ToWidgetWindowElement,
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

{ #category : #initialization }
ToPopupWindow >> defaulPositiontHook [

	^ [ :window :event |  window widget bounds inSpace bounds bottomLeft ]
]

{ #category : #'t - initialization dresser' }
ToPopupWindow >> defaultDresser [ 

	^ ToPopupWindowDresser new
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupEvent: anEvent [

	self cleanUp.
	self widget ifNotNil: [ :w |
		w dispatchEvent: (ToWidgetWindowOpenedEvent new
				 window: self;
				 sourceEvent: anEvent;
				 yourself) ].
			
	super popupEvent: anEvent
]

{ #category : #'api - displaying' }
ToPopupWindow >> spaceLayer [ 

	self widget isAttachedToSceneGraph ifFalse: [ ^ nil ].
	^ self widget space popupLayer.
 
]
