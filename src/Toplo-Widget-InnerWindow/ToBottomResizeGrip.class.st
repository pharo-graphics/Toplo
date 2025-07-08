Class {
	#name : #ToBottomResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToBottomResizeGrip >> cursorSelector [

	^ #resizeBottom
]

{ #category : #initialization }
ToBottomResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialSize x @ (initialSize y + deltaFromInitialPosition y)
]

{ #category : #initialization }
ToBottomResizeGrip >> layoutIn: anElement [

	self extent: anElement width - (thickness * 2) @ thickness.
	self position: thickness @ (anElement height - (thickness / 2))
]
