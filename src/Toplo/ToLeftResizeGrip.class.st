Class {
	#name : #ToLeftResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToLeftResizeGrip >> cursorSelector [

	^ #resizeLeft
]

{ #category : #'mouse processing' }
ToLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	anElement extent:
		initialExtent x - deltaFromInitialPosition x
		@ initialExtent y
]

{ #category : #'mouse processing' }
ToLeftResizeGrip >> layoutGripTarget: anElement [

	self extent: thickness @ (anElement height - (thickness * 2)).
	self position: (thickness / 2) negated @ thickness
]
