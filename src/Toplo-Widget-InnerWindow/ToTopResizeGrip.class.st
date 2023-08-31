Class {
	#name : #ToTopResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #accessing }
ToTopResizeGrip >> cursorSelector [

	^ #resizeTop
]

{ #category : #initialization }
ToTopResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialTargetPosition x
		@ (initialTargetPosition y + deltaFromInitialPosition y).
	anElement size:
		initialTargetSize x
		@ (initialTargetSize y - deltaFromInitialPosition y)
]

{ #category : #initialization }
ToTopResizeGrip >> layoutIn: anElement [

	self size: anElement width - (thickness * 2) @ thickness.
	self position: thickness @ (thickness / 2) negated
]
