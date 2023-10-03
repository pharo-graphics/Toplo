Class {
	#name : #ToPopupWindow,
	#superclass : #ToBasicPopupWindowElement,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToPopupWindow >> checkBeforePopup [

	| gap rect |
	" layout is done, aWindow bounds are now up-to-date"" check if 
	aWindow position is ok according to aWindow extent and the space extent"
	rect := self bounds inSpace asRectangle.
	gap := rect amountToTranslateWithin: (0 asPoint extent: self space extent).
	self position: self position + gap.
	super checkBeforePopup
]

{ #category : #initialization }
ToPopupWindow >> defaulPositionHook [

	^ [ :window :event |  window widget bounds inSpace bounds bottomLeft ]
]

{ #category : #accessing }
ToPopupWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 500)
]

{ #category : #initialization }
ToPopupWindow >> defaultEventHandler [ 
	
	^ self defaultEventHandlerClass new
]

{ #category : #initialization }
ToPopupWindow >> defaultEventHandlerClass [
	
	^ ToPopupWindowEventHandler
]

{ #category : #initialization }
ToPopupWindow >> defaultWidgetEventHandlerClass [

	^ ToWidgetInPopupWindowEventHandler 
]

{ #category : #initialization }
ToPopupWindow >> initialize [ 

	super initialize.
	self addEventHandler: self defaultEventHandler 
]
