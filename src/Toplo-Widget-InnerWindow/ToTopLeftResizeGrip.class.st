Class {
	#name : #ToTopLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToTopLeftResizeGrip >> cursorSelector [

	^ #resizeTopLeft
]

{ #category : #initialization }
ToTopLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	anElement size:
		initialSize x - deltaFromInitialPosition x
		@ (initialSize y - deltaFromInitialPosition y)
]

{ #category : #initialization }
ToTopLeftResizeGrip >> layoutIn: anElement [

	super layoutIn: anElement.
	self position: (thickness @ thickness) negated
]
