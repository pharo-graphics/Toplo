Class {
	#name : #ToElementBottomRightAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomRightAnchor >> readRectangle: aRectangle [

	^ aRectangle bottomRight + (element margin right @ element margin bottom)
]
