Class {
	#name : #ToLeftResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToLeftResizeGrip >> cursorSelector [

	^ #resizeLeft
]

{ #category : #initialization }
ToLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialTargetPosition x + deltaFromInitialPosition x
		@ initialTargetPosition y.
	anElement size:
		initialTargetSize x - deltaFromInitialPosition x
		@ initialTargetSize y
]

{ #category : #initialization }
ToLeftResizeGrip >> layoutIn: anElement [

	self size: thickness @ (anElement height - (thickness * 2)).
	self position: (thickness / 2) negated @ thickness
]
