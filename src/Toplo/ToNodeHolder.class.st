Class {
	#name : #ToNodeHolder,
	#superclass : #OBlInfiniteHolder,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'data'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #accessing }
ToNodeHolder >> data: aData [ 

	data := aData.
	itemElement := infiniteElement nodeFactory cull: aData cull: self
]

{ #category : #accessing }
ToNodeHolder >> onAttachedFromDatasource: aDataSource [


	" when holder is attached it can be already selected (as an example with a selectAll) "
	
	self flag: 'Selection must be preserved when adding/removing in the datasource list '.
	
	(infiniteElement selectionStrategy isSelected: self layoutPosition) ifTrue: [ 
		itemElement dresser addedToSelection: itemElement ].

	self
		whenAnnouncement: ToClickOnNodeAnnouncement
		send: #whenClickOnNodeAnnouncement:
		to: infiniteElement.

	infiniteElement selectionStrategy
		whenAnnouncement: ToDeselectAnnouncement
		send: #whenDeselectAnnouncement:
		to: self.

	infiniteElement selectionStrategy
		whenAnnouncement: ToSelectAnnouncement
		send: #whenSelectAnnouncement:
		to: self.
]

{ #category : #accessing }
ToNodeHolder >> onDetachedFromDatasource: aDataSource [

	itemElement undress.
	self unsubscribe: infiniteElement.
	infiniteElement selectionStrategy unsubscribe: self
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenDeselectAnnouncement: anAnnouncement [

	(anAnnouncement interval includes: self layoutPosition) 
		ifTrue: [ itemElement dresser removedFromSelection: itemElement ]
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenSelectAnnouncement: anAnnouncement [

	(anAnnouncement interval includes: self layoutPosition) 
		ifTrue: [ itemElement dresser addedToSelection: itemElement ]
]
