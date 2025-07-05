Class {
	#name : #ToElementBottomLeftAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomLeftAnchor >> readRectangle: aRectangle [

	^ aRectangle bottomLeft
]
