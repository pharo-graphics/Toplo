Class {
	#name : 'ToBottomLeftResizeGrip',
	#superclass : 'ToCornerResizeGrip',
	#category : 'Toplo-Widget-InnerWindow',
	#package : 'Toplo-Widget-InnerWindow'
}

{ #category : 'accessing' }
ToBottomLeftResizeGrip >> cursorSelector [

	^ #resizeBottomLeft
]

{ #category : 'initialization' }
ToBottomLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	anElement size:
		initialSize x - deltaFromInitialPosition x
		@ (initialSize y + deltaFromInitialPosition y)
]

{ #category : 'initialization' }
ToBottomLeftResizeGrip >> layoutIn: anElement [

	super layoutIn: anElement.
	self position: 0 @ anElement height - (thickness @ thickness)
]
