Class {
	#name : #ToBottomLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToBottomLeftResizeGrip >> cursorSelector [

	^ #resizeBottomLeft
]

{ #category : #'mouse processing' }
ToBottomLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	anElement extent:
		initialExtent x - deltaFromInitialPosition x
		@ (initialExtent y + deltaFromInitialPosition y)
]

{ #category : #'mouse processing' }
ToBottomLeftResizeGrip >> layoutGripTarget: anElement [

	super layoutGripTarget: anElement.
	self position: 0 @ anElement height - (thickness @ thickness)
]
