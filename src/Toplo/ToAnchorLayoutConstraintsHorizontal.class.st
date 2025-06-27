Class {
	#name : #ToAnchorLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #'anchor creation' }
ToAnchorLayoutConstraintsHorizontal >> breadthAnchor [

	^ ToWidthAnchor new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraintsHorizontal >> centerAnchor [

	^ ToHorizontalCenterAnchor new
]
