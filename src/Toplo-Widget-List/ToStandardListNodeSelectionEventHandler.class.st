Class {
	#name : #ToStandardListNodeSelectionEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#instVars : [
		'clickLauncher'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> clickLauncher: aProcessOrNil [

	clickLauncher := aProcessOrNil
]

{ #category : #'api - accessing' }
ToStandardListNodeSelectionEventHandler >> eventsToHandle [ 

	^ super eventsToHandle, { ToListClickOnNodeEvent. ToListDoubleClickOnNodeEvent }
]

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> hasClickLauncher [

	^ clickLauncher notNil
]

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> launchClick: aBlock event: anEvent for: anElement [
	" click launcher management to allow double click to work with several selected nodes "

	| infinite listElement |
	infinite := anElement holder infiniteElement.
	listElement := anEvent sourceEvent currentTarget.
	infinite isFocused ifFalse: [
		infinite requestFocus.
		infinite selectionStrategy selectedIndexes size > 1 ifTrue: [
			listElement preserveSelectionOnFocused ifTrue: [ ^ self ] ] ].

	" do not try double click if ctrl or Cmd or shift is pressed "
	(anElement holder isSelected not or: [
		 anEvent sourceEvent modifiers isPrimaryModifier or: [
			 anEvent sourceEvent modifiers isShift ] ]) ifTrue: [
		self terminateClickLauncher.
		^ aBlock value ].


	" Already has a click launcher "
	self hasClickLauncher ifTrue: [ ^ self ].

	" no click launcher for only one selected node "
	infinite selectionStrategy selectedIndexes size > 1 ifFalse: [
		^ aBlock value ].

	self clickLauncher: ([
		 (Delay forMilliseconds: 250) wait.
		 aBlock value.
		 self clickLauncher: nil ]
			 forkAt: Processor highIOPriority
			 named: 'ToNodeDresser clickLauncher')
]

{ #category : #'mouse handlers' }
ToStandardListNodeSelectionEventHandler >> listClickOnNodeEvent: anEvent [

	| infiniteElement target |
	target := anEvent currentTarget.
	infiniteElement := target holder infiniteElement.

	infiniteElement selectionStrategy dispatchEvent: (ToListClickOnNodeEvent new
			 sourceEvent: anEvent;
			 listElement: infiniteElement;
			 yourself).
	self
		launchClick: [ self onClickOnNodeEvent: anEvent ]
		event: anEvent
		for: anEvent currentTarget.
	anEvent consumed: true
]

{ #category : #'mouse handlers' }
ToStandardListNodeSelectionEventHandler >> listDoubleClickOnNodeEvent: anEvent [

	| infiniteElement target |
	self terminateClickLauncher.
	target := anEvent currentTarget.
	infiniteElement := target holder infiniteElement.
	infiniteElement selectionStrategy dispatchStrongSelectionChanged
]

{ #category : #'selection events' }
ToStandardListNodeSelectionEventHandler >> onClickOnNodeEvent: anEvent [

	| infiniteElement target |
	target := anEvent currentTarget.

	infiniteElement := target holder infiniteElement.
	infiniteElement selectionStrategy multipleSelectionModeDo: [
		anEvent sourceEvent modifiers isShift ifTrue: [
			^ infiniteElement selectionStrategy selectToIndex:
				  target holder position ].
		anEvent sourceEvent modifiers isPrimaryModifier ifTrue: [
			^ infiniteElement selectionStrategy cherryPickIndex:
				  target holder position ] ].

	infiniteElement selectionStrategy atLeastMonoSelectionDo: [
		infiniteElement selectionStrategy selectOnlyIndex:
			target holder position ]
]

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> terminateClickLauncher [

	clickLauncher ifNotNil: #terminate.
	clickLauncher := nil.
]
