Class {
	#name : #ToLeftResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToLeftResizeGrip >> cursorSelector [

	^ #resizeLeft
]

{ #category : #initialization }
ToLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	anElement size:
		initialSize x - deltaFromInitialPosition x
		@ initialSize y
]

{ #category : #initialization }
ToLeftResizeGrip >> layoutIn: anElement [

	self size: thickness @ (anElement height - (thickness * 2)).
	self position: (thickness / 2) negated @ thickness
]
