Class {
	#name : #ToPopupWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToPopupWindow >> afterCustomizedToFitAnchorRootDo: aBlock [

	| p |
	p := self correctedPositionWithinAnchorRoot.
	p ~= self position ifTrue: [
		self position: p.
		self whenLayoutedDoOnce: aBlock.
		^ self ].
	aBlock value
]

{ #category : #accessing }
ToPopupWindow >> closedEventClass [ 

	^ ToPopupWindowClosedEvent 
]

{ #category : #'api - displaying' }
ToPopupWindow >> correctedPositionWithinAnchorRoot [

	^ self position
]

{ #category : #accessing }
ToPopupWindow >> openedEventClass [ 

	^ ToPopupWindowOpenedEvent 
]
