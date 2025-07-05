Class {
	#name : #ToElementBottomRightAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomRightAnchor >> readRectangle: aRectangle [

	^ aRectangle bottomRight
]
