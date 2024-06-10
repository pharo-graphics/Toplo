Class {
	#name : #ToListNodeMultiSelectionClickEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#instVars : [
		'clickLauncher'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
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

	| listElement node holder mode |
	node := anEvent currentTarget.
	holder := node holder.
	listElement := node holder listElement.
	mode := listElement selectionMode.

	(listElement isFocused not and: [listElement selectionMode requestFocusOnMouseDown]) ifTrue: [
		listElement requestFocus.
		mode preserveSelectionOnFocused ifTrue: [
			self terminateClickLauncher.
			^ self ] ].

	" do not try double click if ctrl or Cmd or shift is pressed "
	(holder isSelected not or: [
		 anEvent sourceEvent modifiers isPrimaryModifier or: [
			 anEvent sourceEvent modifiers isShift ] ]) ifTrue: [
		self terminateClickLauncher.
		^ aBlock value ].

	" Already have a click launcher "
	self hasClickLauncher ifTrue: [ ^ self ].
	
	" no click launcher for only one selected node "
	" Avoid selection size computation if all is selected "
	(mode selectedIndexesCount > 0)
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

	super listClickOnNodeEvent: anEvent.
	self launchClick: [ self onClickOnNodeEvent: anEvent ] event: anEvent.
	anEvent consume
]

{ #category : #'mouse handlers' }
ToListNodeMultiSelectionClickEventHandler >> listDoubleClickEvent: anEvent [

	self terminateClickLauncher.
	super listDoubleClickEvent: anEvent
]

{ #category : #'selection events' }
ToListNodeMultiSelectionClickEventHandler >> onClickOnNodeEvent: anEvent [

	| listElement node holder mode |
	node := anEvent currentTarget.
	holder := node holder.
	listElement := node holder listElement.
	mode := listElement selectionMode.
	mode onClickEvent: anEvent onNode: node
]

{ #category : #'events handling' }
ToListNodeMultiSelectionClickEventHandler >> terminateClickLauncher [

	clickLauncher ifNotNil: #terminate.
	clickLauncher := nil.
]
