Class {
	#name : #ToStandardNodeSelectionEventHandler,
	#superclass : #ToNodeSelectionEventHandler,
	#instVars : [
		'monitor',
		'clickLauncher'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'mouse handlers' }
ToStandardNodeSelectionEventHandler >> clickEvent: anEvent [

	self
		launchClick: [
			self onClickOnNodeEvent: anEvent ]
		event: anEvent
		for: anEvent currentTarget.
	anEvent consumed: true
]

{ #category : #'events handling' }
ToStandardNodeSelectionEventHandler >> clickLauncher: aProcessOrNil [

	clickLauncher := aProcessOrNil
]

{ #category : #'api - accessing' }
ToStandardNodeSelectionEventHandler >> eventsToHandle [ 

	^ super eventsToHandle, { BlPrimaryClickEvent. ToStrongSelectionEvent }
]

{ #category : #'events handling' }
ToStandardNodeSelectionEventHandler >> hasClickLauncher [

	^ clickLauncher notNil
]

{ #category : #'events handling' }
ToStandardNodeSelectionEventHandler >> launchClick: aBlock event: anEvent for: anElement [
	" click launcher management to allow double click to work with several selected nodes "

	| infinite |
	infinite := anElement holder infiniteElement.

	infinite isFocused ifFalse: [
		infinite selection isNotEmpty ifTrue: [
			(infinite preserveSelectionOnFocused and: [
				 infinite requestFocusOnMouseDown ]) ifTrue: [
				infinite requestFocus.
				^ self ] ] ].

	" do not try double click if ctrl or Cmd or shift is pressed "
	(anElement holder isSelected not or: [
		 anEvent modifiers isPrimaryModifier or: [
			 anEvent modifiers isShift ] ]) ifTrue: [
		self terminateClickLauncher.
		^ aBlock value ].


	" Already has a click launcher "
	self hasClickLauncher ifTrue: [ ^ self ].

	" no click launcher for only one selected node "
	infinite selection selectedIndexes size > 1 ifFalse: [
		^ aBlock value ].

	monitor critical: [
		self clickLauncher: ([
			 (Delay forMilliseconds: 250) wait.
			 aBlock value.
			 self clickLauncher: nil ]
				 forkAt: Processor highIOPriority
				 named: 'ToNodeDresser clickLauncher') ]
]

{ #category : #'selection events' }
ToStandardNodeSelectionEventHandler >> onClickOnNodeEvent: anEvent [

	| infiniteElement target |
	target := anEvent currentTarget.
	infiniteElement := target holder infiniteElement.
	infiniteElement selection multipleSelectionModeDo: [
		anEvent modifiers isShift ifTrue: [
			^ infiniteElement selection selectToIndex: target holder position ].
		anEvent modifiers isPrimaryModifier ifTrue: [
			^ infiniteElement selection cherryPickIndex: target holder position ] ].

	infiniteElement selection atLeastMonoSelectionDo: [
		infiniteElement selection selectOnlyIndex: target holder position ]
]

{ #category : #'api - hooks' }
ToStandardNodeSelectionEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	monitor := Monitor new
]

{ #category : #'api - hooks' }
ToStandardNodeSelectionEventHandler >> onUninstalledIn: anElement [

	monitor := nil.
	super onUninstalledIn: anElement.

]

{ #category : #'events handling' }
ToStandardNodeSelectionEventHandler >> strongSelectionEvent: anEvent [

	self terminateClickLauncher
]

{ #category : #'events handling' }
ToStandardNodeSelectionEventHandler >> terminateClickLauncher [

	clickLauncher ifNotNil: #terminate.
	clickLauncher := nil.
]
