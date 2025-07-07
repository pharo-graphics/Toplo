Class {
	#name : #ToElementTopRightAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopRightAnchor >> valueInBounds: aBounds [

	^ aBounds topRight
]
