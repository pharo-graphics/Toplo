Class {
	#name : #ToNodeHolder,
	#superclass : #OBlInfiniteHolder,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'data',
		'nodeDresser'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #accessing }
ToNodeHolder >> data: aData [ 

	data := aData.
	itemElement := infiniteElement nodeFactory value: aData
]

{ #category : #accessing }
ToNodeHolder >> dressNodeWith: aDresser [

	nodeDresser := aDresser.
	self itemElement addDresser: nodeDresser.
	infiniteElement selectionModel
		whenAnnouncement: ToDeselectAnnouncement
		send: #whenDeselectAnnouncement:
		to: self.
	infiniteElement selectionModel
		whenAnnouncement: ToSelectAnnouncement
		send: #whenSelectAnnouncement:
		to: self.
]

{ #category : #accessing }
ToNodeHolder >> undressNode [

	infiniteElement selectionModel unsubscribe: self.
	self itemElement removeDresser: nodeDresser.
	nodeDresser := nil.

]

{ #category : #'selection - handling' }
ToNodeHolder >> whenDeselectAnnouncement: anAnnouncement [

	(anAnnouncement interval includes: self layoutPosition) 
		ifTrue: [ nodeDresser removedFromSelection: itemElement ]
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenSelectAnnouncement: anAnnouncement [

	(anAnnouncement interval includes: self layoutPosition) 
		ifTrue: [ nodeDresser addedToSelection: itemElement ]
]
