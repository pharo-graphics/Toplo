Class {
	#name : #ToElementTopRightAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopRightAnchor >> readRectangle: aRectangle [

	^ aRectangle topRight + (element margin right @ element margin top negated)
]
