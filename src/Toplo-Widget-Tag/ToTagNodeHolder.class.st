Class {
	#name : #ToTagNodeHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #removing }
ToTagNodeHolder >> removeNodeFromBar [

]

{ #category : #accessing }
ToTagNodeHolder >> tagModel [

	^ self dataItem
]

{ #category : #accessing }
ToTagNodeHolder >> withCloseButton [

	^  self listElement withCloseButton
]
