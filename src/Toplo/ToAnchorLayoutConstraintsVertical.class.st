Class {
	#name : #ToAnchorLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #'anchor creation' }
ToAnchorLayoutConstraintsVertical >> breadthAnchor [

	^ ToElementHeightAnchor new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraintsVertical >> centerAnchor [

	^ ToElementVerticalCenterAnchor new
]
