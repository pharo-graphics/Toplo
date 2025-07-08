Class {
	#name : #ToCornerResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #'mouse processing' }
ToCornerResizeGrip >> layoutIn: anElement [

	self extent: (thickness * 2) asPoint
]
