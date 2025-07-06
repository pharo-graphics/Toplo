Class {
	#name : #ToElementTopLeftAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopLeftAnchor >> readRectangle: aRectangle [

	^ aRectangle topLeft + (element margin left @ element margin top) negated
]
