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

{ #category : #initialization }
ToNodeHolder >> initialize [ 

	super initialize
]

{ #category : #private }
ToNodeHolder >> offsetPositionBy: anOffset applyToPreLayout: shouldApplyOnPreLayout [

	| wasSelected |
	wasSelected := false.
	(infiniteElement selectionStrategy isSelected: self position) ifTrue: [
		infiniteElement selectionStrategy clearSelection: self position.
		wasSelected := true ]. 
	super
		offsetPositionBy: anOffset
		applyToPreLayout: shouldApplyOnPreLayout.
	anOffset < 0 ifTrue: [ ^ self ].
	wasSelected ifTrue: [ infiniteElement selectionStrategy cherryPickIndex: self position ]
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
ToNodeHolder >> onDetachedFromDatasource: aDataSource [

	itemElement undress.
	self unsubscribe: infiniteElement.
	infiniteElement selectionStrategy unsubscribe: self
]

{ #category : #accessing }
ToNodeHolder >> selected: aBoolean [
	aBoolean
		ifTrue: [ itemElement dresser addedToSelection: itemElement ]
		ifFalse: [ itemElement dresser removedFromSelection: itemElement ]
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
