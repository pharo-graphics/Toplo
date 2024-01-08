Class {
	#name : #ToStandardListNodeSelectionEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#instVars : [
		'monitor',
		'clickLauncher'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'mouse handlers' }
ToStandardListNodeSelectionEventHandler >> clickEvent: anEvent [

	self
		launchClick: [
			self onClickOnNodeEvent: anEvent ]
		event: anEvent
		for: anEvent currentTarget.
	anEvent consumed: true
]

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> clickLauncher: aProcessOrNil [

	clickLauncher := aProcessOrNil
]

{ #category : #'api - accessing' }
ToStandardListNodeSelectionEventHandler >> eventsToHandle [ 

	^ { BlPrimaryClickEvent. ToListStrongSelectionEvent }
]

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> hasClickLauncher [

	^ clickLauncher notNil
]

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> launchClick: aBlock event: anEvent for: anElement [
	" click launcher management to allow double click to work with several selected nodes "

	| infinite |

	infinite := anElement holder infiniteElement.
		
	infinite isFocused ifFalse: [
		infinite hasSelection ifTrue: [
			infinite preserveSelectionOnFocused ifTrue: [
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
	infinite primarySelectionIndexes size > 1 ifFalse: [ ^ aBlock value ].

	monitor critical: [
		self clickLauncher: ([
			 (Delay forMilliseconds: 250) wait.
			 aBlock value.
			 self clickLauncher: nil ]
				 forkAt: Processor highIOPriority
				 named: 'ToNodeDresser clickLauncher') ]
]

{ #category : #'selection events' }
ToStandardListNodeSelectionEventHandler >> onClickOnNodeEvent: anEvent [

	| infiniteElement target |
	target := anEvent currentTarget.
	infiniteElement := target holder infiniteElement.
	infiniteElement primarySelection multipleSelectionModeDo: [
		anEvent modifiers isShift ifTrue: [
			^ infiniteElement selectToIndex: target holder position ].
		anEvent modifiers isPrimaryModifier ifTrue: [
			^ infiniteElement cherryPickIndex: target holder position ] ].

	infiniteElement primarySelection atLeastMonoSelectionDo: [
		infiniteElement selectOnlyIndex: target holder position ]
]

{ #category : #'api - hooks' }
ToStandardListNodeSelectionEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	monitor := Monitor new
]

{ #category : #'api - hooks' }
ToStandardListNodeSelectionEventHandler >> onUninstalledIn: anElement [

	monitor := nil.
	super onUninstalledIn: anElement.

]

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> strongSelectionEvent: anEvent [

	self terminateClickLauncher
]

{ #category : #'events handling' }
ToStandardListNodeSelectionEventHandler >> terminateClickLauncher [

	clickLauncher ifNotNil: #terminate.
	clickLauncher := nil.
]
