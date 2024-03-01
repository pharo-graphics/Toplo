Class {
	#name : #ToListNodeMultiSelectionClickEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#instVars : [
		'clickLauncher'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'events handling' }
ToListNodeMultiSelectionClickEventHandler >> clickEvent: anEvent [

	| node listElement mode |
	node := anEvent currentTarget.
	node holder isUnselectable ifTrue: [ ^ self ].
	listElement := node holder listElement.
	mode := listElement selectionMode.
	mode selectOnMouseDown ifTrue: [ ^ self ].
	self
		launchClick: [ self onClickOnNodeEvent: anEvent ]
		event: anEvent.
	anEvent consumed: true
]

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
		 anEvent modifiers isPrimaryModifier or: [
			 anEvent modifiers isShift ] ]) ifTrue: [
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

{ #category : #'mouse handlers' }
ToListNodeMultiSelectionClickEventHandler >> primaryMouseDownEvent: anEvent [

	| target listElement mode |
	super primaryMouseDownEvent: anEvent.
	target := anEvent currentTarget.
	listElement := target holder listElement.
	mode := listElement selectionMode.
	mode selectOnMouseDown ifFalse: [ ^ self ].
	self launchClick: [ self onClickOnNodeEvent: anEvent ] event: anEvent.
	anEvent consumed: true
]

{ #category : #'events handling' }
ToListNodeMultiSelectionClickEventHandler >> terminateClickLauncher [

	clickLauncher ifNotNil: #terminate.
	clickLauncher := nil.
]
