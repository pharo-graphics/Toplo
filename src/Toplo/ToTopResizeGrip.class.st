Class {
	#name : #ToTopResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToTopResizeGrip >> cursorSelector [

	^ #resizeTop
]

{ #category : #'mouse processing' }
ToTopResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	anElement extent:
		initialExtent x
		@ (initialExtent y - deltaFromInitialPosition y)
]

{ #category : #'mouse processing' }
ToTopResizeGrip >> layoutGripTarget: anElement [

	self extent: anElement width - (thickness * 2) @ thickness.
	self position: thickness @ (thickness / 2) negated
]
