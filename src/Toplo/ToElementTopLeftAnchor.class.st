Class {
	#name : #ToElementTopLeftAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopLeftAnchor >> readRectangle: aRectangle [

	^ aRectangle topLeft
]
