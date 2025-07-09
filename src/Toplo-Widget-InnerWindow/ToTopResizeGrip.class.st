Class {
	#name : #ToTopResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToTopResizeGrip >> cursorSelector [

	^ #resizeTop
]

{ #category : #initialization }
ToTopResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	anElement extent:
		initialExtent x
		@ (initialExtent y - deltaFromInitialPosition y)
]

{ #category : #initialization }
ToTopResizeGrip >> layoutIn: anElement [

	self extent: anElement width - (thickness * 2) @ thickness.
	self position: thickness @ (thickness / 2) negated
]
