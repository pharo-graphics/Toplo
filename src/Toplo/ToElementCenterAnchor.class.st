Class {
	#name : #ToElementCenterAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementCenterAnchor >> valueInBounds: aBounds [

	^ aBounds center
]
