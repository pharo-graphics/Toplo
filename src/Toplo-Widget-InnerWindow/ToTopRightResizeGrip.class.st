Class {
	#name : #ToTopRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToTopRightResizeGrip >> cursorSelector [

	^ #resizeTopRight
]

{ #category : #initialization }
ToTopRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	anElement extent:
		initialExtent x + deltaFromInitialPosition x
		@ (initialExtent y - deltaFromInitialPosition y)
]

{ #category : #initialization }
ToTopRightResizeGrip >> layoutIn: anElement [

	super layoutIn: anElement.
	self position: anElement width - thickness @ thickness negated
]
