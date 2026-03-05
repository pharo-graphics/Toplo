Class {
	#name : #ToBottomResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToBottomResizeGrip >> cursorSelector [

	^ #resizeBottom
]

{ #category : #'mouse processing' }
ToBottomResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialExtent x
		@ (initialExtent y + deltaFromInitialPosition y)
]

{ #category : #'mouse processing' }
ToBottomResizeGrip >> layoutGripTarget: anElement [

	self extent: anElement width - (thickness * 2) @ thickness.
	self position: thickness @ (anElement height - (thickness / 2))
]
