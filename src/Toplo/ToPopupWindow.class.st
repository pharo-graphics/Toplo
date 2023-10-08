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
