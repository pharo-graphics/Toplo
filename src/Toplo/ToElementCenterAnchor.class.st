Class {
	#name : #ToElementCenterAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementCenterAnchor >> readRectangle: aRectangle [

	^ aRectangle center + element margin topLeft - element margin bottomRight
]
