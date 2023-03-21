Class {
	#name : #ToNodeHolder,
	#superclass : #OBlInfiniteHolder,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'data',
		'unselectedNode'
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

	^ self infiniteElement selectionStrategy isSelected: self position
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
]

{ #category : #accessing }
ToNodeHolder >> onAttachedFromInfinite [

	" when holder is attached it can be already selected (as an example with a selectAll) "
	"Selection must be preserved "
	self isSelected
		ifFalse: [ ^ self ].
	self selected: true.


]

{ #category : #accessing }
ToNodeHolder >> onDetachedFromDatasource: aDataSource [

	itemElement undress.
	self unsubscribe: infiniteElement.
	infiniteElement selectionStrategy unsubscribe: self
]

{ #category : #accessing }
ToNodeHolder >> onDetachedFromInfinite [

	
]

{ #category : #'selection - handling' }
ToNodeHolder >> recoverUnselectedNode [

	unselectedNode ifNotNil: [
		self node undress.
		self node: unselectedNode.
		unselectedNode := nil.
		self infiniteElement requestLayout ]
]

{ #category : #accessing }
ToNodeHolder >> selected: aBoolean [

	aBoolean
		ifTrue: [ self node selectedInInfiniteElement ]
		ifFalse: [ self node deselectedInInfiniteElement ]
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenDeselectAnnouncement: anAnnouncement [

	(anAnnouncement interval includes: self position) ifFalse: [ ^ self ].
	self recoverUnselectedNode.
	self selected: false
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenSelectAnnouncement: anAnnouncement [

	(anAnnouncement interval includes: self position) ifFalse: [ ^ self ].
	self selected: true
]
