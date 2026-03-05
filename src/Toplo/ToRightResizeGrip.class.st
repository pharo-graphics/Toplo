Class {
	#name : #ToRightResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToRightResizeGrip >> cursorSelector [

	^ #resizeRight
]

{ #category : #'mouse processing' }
ToRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialExtent x + deltaFromInitialPosition x
		@ initialExtent y
]

{ #category : #'mouse processing' }
ToRightResizeGrip >> layoutGripTarget: anElement [

	self extent: thickness @ (anElement height - (thickness * 2)).
	self position: anElement width - (thickness / 2) @ thickness
]
