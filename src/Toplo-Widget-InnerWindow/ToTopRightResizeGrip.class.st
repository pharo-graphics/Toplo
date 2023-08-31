Class {
	#name : #ToTopRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #accessing }
ToTopRightResizeGrip >> cursorSelector [

	^ #resizeTopRight
]

{ #category : #initialization }
ToTopRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialTargetPosition x
		@ (initialTargetPosition y + deltaFromInitialPosition y).
	anElement size:
		initialTargetSize x + deltaFromInitialPosition x
		@ (initialTargetSize y - deltaFromInitialPosition y)
]

{ #category : #initialization }
ToTopRightResizeGrip >> layoutIn: anElement [

	self size: thickness @ thickness.
	self position:
		anElement width - (thickness / 2) @ (thickness / 2) negated
]
