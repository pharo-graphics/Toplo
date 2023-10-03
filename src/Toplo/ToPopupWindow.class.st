Class {
	#name : #ToPopupWindow,
	#superclass : #ToWidgetWindowElement,
	#category : #'Toplo-Core-Window'
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
ToPopupWindow >> defaulPositionHook [

	^ [ :window :event |  window widget bounds inSpace bounds bottomLeft ]
]

{ #category : #initialization }
ToPopupWindow >> defaultEventHandler [ 
	
	^ ToPopupWindowEventHandler new
]

{ #category : #initialization }
ToPopupWindow >> defaultWidgetEventHandler [ 

	^ ToWidgetInPopupWindowEventHandler new
]

{ #category : #initialization }
ToPopupWindow >> initialize [ 

	super initialize.
	self addEventHandler: self defaultEventHandler 
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupEvent: anEvent [

	self cleanUp.	
	super popupEvent: anEvent
]
