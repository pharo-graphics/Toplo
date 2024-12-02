Class {
	#name : #ToPopupWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToPopupWindow >> allowPickOutsideClosing [

	windowManager plugPickOutsideFilter
]

{ #category : #accessing }
ToPopupWindow >> closedEventClass [ 

	^ ToPopupWindowClosedEvent 
]

{ #category : #accessing }
ToPopupWindow >> openedEventClass [ 

	^ ToPopupWindowOpenedEvent 
]

{ #category : #'api - displaying' }
ToPopupWindow >> preventPickOutsideClosing [

	windowManager unplugPickOutsideFilter
]
