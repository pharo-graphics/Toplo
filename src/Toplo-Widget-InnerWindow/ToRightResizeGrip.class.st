Class {
	#name : #ToRightResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToRightResizeGrip >> cursorSelector [

	^ #resizeRight
]

{ #category : #initialization }
ToRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialExtent x + deltaFromInitialPosition x
		@ initialExtent y
]

{ #category : #initialization }
ToRightResizeGrip >> layoutIn: anElement [

	self extent: thickness @ (anElement height - (thickness * 2)).
	self position: anElement width - (thickness / 2) @ thickness
]
