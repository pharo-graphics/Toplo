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
ToNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToNodeHolder >> data: aData [ 

	data := aData.
	self node: (infiniteElement nodeFactory cull: aData cull: self)
]

{ #category : #initialization }
ToNodeHolder >> initialize [ 

	super initialize
]

{ #category : #accessing }
ToNodeHolder >> isSelected [

	^ self infiniteElement isSelectedAtIndex: self position
]

{ #category : #accessing }
ToNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : #accessing }
ToNodeHolder >> onAttachedFromDatasource: aDataSource [

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

	" when holder is attached it can be already selected (as an example with a selectAll) "
	"Selection must be preserved "
	self isSelected ifFalse: [ ^ self ].
	self selected: true.


]

{ #category : #accessing }
ToNodeHolder >> onDetachedFromDatasource: aDataSource [

	itemElement undress.
	self unsubscribe: infiniteElement.
	infiniteElement selectionStrategy unsubscribe: self
]

{ #category : #accessing }
ToNodeHolder >> selected: aBoolean [

	aBoolean
		ifTrue: [ self node dispatchEvent: (ToNodeHolderSelectedEvent new holder: self; yourself) ]
		ifFalse: [ self node dispatchEvent: (ToNodeHolderDeselectedEvent new holder: self; yourself) ]
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenDeselectAnnouncement: anAnnouncement [

	(anAnnouncement interval includes: self position) ifFalse: [ ^ self ].
	self selected: false
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenSelectAnnouncement: anAnnouncement [

	(anAnnouncement interval includes: self position) ifFalse: [ ^ self ].
	self selected: true
]
