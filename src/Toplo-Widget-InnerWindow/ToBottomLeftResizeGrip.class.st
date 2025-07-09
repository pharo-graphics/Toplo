Class {
	#name : #ToBottomLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToBottomLeftResizeGrip >> cursorSelector [

	^ #resizeBottomLeft
]

{ #category : #initialization }
ToBottomLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	anElement extent:
		initialExtent x - deltaFromInitialPosition x
		@ (initialExtent y + deltaFromInitialPosition y)
]

{ #category : #initialization }
ToBottomLeftResizeGrip >> layoutIn: anElement [

	super layoutIn: anElement.
	self position: 0 @ anElement height - (thickness @ thickness)
]
