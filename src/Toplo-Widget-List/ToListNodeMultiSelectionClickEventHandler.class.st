Class {
	#name : #ToListNodeMultiSelectionClickEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#instVars : [
		'clickLauncher'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'events handling' }
ToListNodeMultiSelectionClickEventHandler >> clickLauncher: aProcessOrNil [

	clickLauncher := aProcessOrNil
]

{ #category : #'events handling' }
ToListNodeMultiSelectionClickEventHandler >> hasClickLauncher [

	^ clickLauncher notNil
]

{ #category : #'events handling' }
ToListNodeMultiSelectionClickEventHandler >> launchClick: aBlock event: anEvent [
	" click launcher management to allow double click to work with several selected nodes "

	| listElement manager |
	listElement := anEvent listElement.
	manager := listElement selectionManager.

	listElement hasFocus ifFalse: [
		listElement requestFocus.
		" Avoid selection size computation if all is selected "
		(manager hasWholeSelection or: [ manager selectionSize > 1 ])
			ifTrue: [ anEvent listElement preserveSelectionOnFocused ifTrue: [ ^ self ] ] ].

	" do not try double click if ctrl or Cmd or shift is pressed "
	(anEvent currentTarget holder isSelected not or: [
		 anEvent sourceEvent modifiers isPrimaryModifier or: [
			 anEvent sourceEvent modifiers isShift ] ]) ifTrue: [
		self terminateClickLauncher.
		^ aBlock value ].

	" Already has a click launcher "
	self hasClickLauncher ifTrue: [ ^ self ].

	" no click launcher for only one selected node "
	" Avoid selection size computation if all is selected "
	(manager hasWholeSelection or: [ manager selectionSize > 0 ])
		ifFalse: [ ^ aBlock value ].

	self clickLauncher: ([
		 (listElement valueOfTokenNamed: #'double-click-delay') asDelay wait.
		 aBlock value.
		 self clickLauncher: nil ]
			 forkAt: Processor highIOPriority
			 named: self class name)
]

{ #category : #'mouse handlers' }
ToListNodeMultiSelectionClickEventHandler >> listClickOnNodeEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self
		launchClick: [ self onClickOnNodeEvent: anEvent ]
		event: anEvent.
	anEvent consumed: true
]

{ #category : #'mouse handlers' }
ToListNodeMultiSelectionClickEventHandler >> listDoubleClickOnNodeEvent: anEvent [

	self terminateClickLauncher.
	super listDoubleClickOnNodeEvent: anEvent
]

{ #category : #'selection events' }
ToListNodeMultiSelectionClickEventHandler >> onClickOnNodeEvent: anEvent [

	anEvent listElement selectionManager
		onClickOnNode: anEvent currentTarget
		event: anEvent sourceEvent
]

{ #category : #'events handling' }
ToListNodeMultiSelectionClickEventHandler >> terminateClickLauncher [

	clickLauncher ifNotNil: #terminate.
	clickLauncher := nil.
]
