Class {
	#name : #ToTopLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToTopLeftResizeGrip >> cursorSelector [

	^ #resizeTopLeft
]

{ #category : #initialization }
ToTopLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialTargetPosition x + deltaFromInitialPosition x
		@ (initialTargetPosition y + deltaFromInitialPosition y).
	anElement size:
		initialTargetSize x - deltaFromInitialPosition x
		@ (initialTargetSize y - deltaFromInitialPosition y)
]

{ #category : #initialization }
ToTopLeftResizeGrip >> layoutIn: anElement [

	self size: thickness @ thickness.
	self position: (thickness / 2 @ (thickness / 2)) negated
]
