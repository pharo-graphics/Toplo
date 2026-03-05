Class {
	#name : #ToCornerResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #'mouse processing' }
ToCornerResizeGrip >> layoutGripTarget: anElement [

	self extent: (thickness * 2) asPoint
]
