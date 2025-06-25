Class {
	#name : #ToAnchorLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #'anchor creation' }
ToAnchorLayoutConstraintsHorizontal >> breadthAnchor [

	^ ToElementWidthAnchor new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraintsHorizontal >> centerAnchor [

	^ ToElementHorizontalCenterAnchor new
]
