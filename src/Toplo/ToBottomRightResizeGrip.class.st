Class {
	#name : #ToBottomRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToBottomRightResizeGrip >> cursorSelector [

	^ #resizeBottomRight
]

{ #category : #'mouse processing' }
ToBottomRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialExtent + deltaFromInitialPosition
]

{ #category : #'mouse processing' }
ToBottomRightResizeGrip >> layoutGripTarget: anElement [

	super layoutGripTarget: anElement.
	self position: anElement extent - (thickness @ thickness)
]
