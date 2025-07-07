Class {
	#name : #ToElementBottomLeftAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomLeftAnchor >> valueInBounds: aBounds [

	^ aBounds bottomLeft
]
