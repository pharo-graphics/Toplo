Class {
	#name : #ToCornerResizeGrip,
	#superclass : #ToPredefinedResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToCornerResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self extent: (thickness * 2) asPoint.

]
