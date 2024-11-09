Class {
	#name : #ToPopupWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #enumerating }
ToPopupWindow >> withAllSubwindowsDo: aBlock [

	aBlock value: self
]
