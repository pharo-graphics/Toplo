Class {
	#name : #ToBottomLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToBottomLeftResizeGrip >> cursorSelector [

	^ #resizeBottomLeft
]

{ #category : #initialization }
ToBottomLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialTargetPosition x + deltaFromInitialPosition x
		@ initialTargetPosition y.
	anElement size:
		initialTargetSize x - deltaFromInitialPosition x
		@ (initialTargetSize y + deltaFromInitialPosition y)
]

{ #category : #initialization }
ToBottomLeftResizeGrip >> layoutIn: anElement [

	self size: thickness @ thickness.
	self position:
		0 @ anElement height - (thickness / 2 @ (thickness / 2))
]
