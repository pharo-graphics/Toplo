Class {
	#name : #ToAnchorLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #'anchor creation' }
ToAnchorLayoutConstraintsVertical >> breadthAnchor [

	^ ToHeightAnchor new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraintsVertical >> centerAnchor [

	^ ToVerticalCenterAnchor new
]
