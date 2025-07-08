Class {
	#name : #ToElementBottomRightAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomRightAnchor >> valueInBounds: aBounds [

	^ aBounds bottomRight
]
