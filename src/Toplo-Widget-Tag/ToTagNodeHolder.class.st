Class {
	#name : #ToTagNodeHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #removing }
ToTagNodeHolder >> removeNodeFromBar [

]

{ #category : #'as yet unclassified' }
ToTagNodeHolder >> withCloseButton [

	^  self listElement nodesWithCloseButton
]
