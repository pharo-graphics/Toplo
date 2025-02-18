Class {
	#name : #ToPopupWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupWindow >> closedEventClass [ 

	^ ToPopupWindowClosedEvent 
]

{ #category : #accessing }
ToPopupWindow >> openedEventClass [ 

	^ ToPopupWindowOpenedEvent 
]
