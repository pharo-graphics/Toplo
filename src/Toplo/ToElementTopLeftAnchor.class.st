Class {
	#name : #ToElementTopLeftAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopLeftAnchor >> valueInBounds: aBounds [

	^ aBounds topLeft
]
