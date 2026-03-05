Class {
	#name : #ToTopRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToTopRightResizeGrip >> cursorSelector [

	^ #resizeTopRight
]

{ #category : #'mouse processing' }
ToTopRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	anElement extent:
		initialExtent x + deltaFromInitialPosition x
		@ (initialExtent y - deltaFromInitialPosition y)
]

{ #category : #'mouse processing' }
ToTopRightResizeGrip >> layoutGripTarget: anElement [

	super layoutGripTarget: anElement.
	self position: anElement width - thickness @ thickness negated
]
