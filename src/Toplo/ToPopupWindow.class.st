Class {
	#name : #ToPopupWindow,
	#superclass : #ToAnchoredWindowElement,
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupWindow >> autoCloseOnMouseUpDelay [

	^ self userData at: #autoCloseOnMouseUpDelay ifAbsentPut: [ 300 milliSeconds ]
]

{ #category : #accessing }
ToPopupWindow >> autoCloseOnMouseUpDelay: aDelay [

	self userData at: #autoCloseOnMouseUpDelay put: aDelay asDelay
]

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

	^ [ :window :event |  window associateElement bounds inSpace bounds bottomLeft ]
]

{ #category : #initialization }
ToPopupWindow >> defaultAssociateElementEventHandlerClass [

	^ ToPopupWindowAssociateElementEventHandler 
]

{ #category : #accessing }
ToPopupWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 500)
]
