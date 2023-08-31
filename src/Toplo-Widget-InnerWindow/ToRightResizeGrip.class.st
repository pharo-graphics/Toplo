Class {
	#name : #ToRightResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #accessing }
ToRightResizeGrip >> cursorSelector [

	^ #resizeRight
]

{ #category : #initialization }
ToRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement size:
		initialTargetSize x + deltaFromInitialPosition x
		@ initialTargetSize y
]

{ #category : #initialization }
ToRightResizeGrip >> layoutIn: anElement [

	self size: thickness @ (anElement height - (thickness * 2)).
	self position: anElement width - (thickness / 2) @ thickness
]
