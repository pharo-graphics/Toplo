Class {
	#name : #ToListNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'clickLauncher'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> clickEvent: anEvent [

	anEvent
		ifPrimary: [ self pickEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'multiple selection' }
ToListNodeSelectionEventHandler >> clickLauncher: aProcessOrNil [

	clickLauncher := aProcessOrNil
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> doubleClickEvent: anEvent [
	
	self terminateClickLauncherOnNode: anEvent currentTarget onEvent: anEvent
]

{ #category : #'api - accessing' }
ToListNodeSelectionEventHandler >> eventsToHandle [

	^ {
		  BlDoubleClickEvent.
		  BlPrimaryMouseDownEvent.
		  BlPrimaryClickEvent.
		  ToListClickOnNodeRequestEvent.
		  ToListClickOnNodeEvent }
]

{ #category : #'multiple selection' }
ToListNodeSelectionEventHandler >> hasClickLauncher [

	^ clickLauncher notNil
]

{ #category : #'multiple selection' }
ToListNodeSelectionEventHandler >> launchClick: aBlock event: anEvent [
	" click launcher management to allow double click to work with several selected nodes "

	| listElement node holder mode dblClickDelay |
	node := anEvent currentTarget.
	holder := node holder.
	listElement := node holder listElement.
	mode := listElement primarySelectionMode.
	dblClickDelay := listElement selectionMode doubleClickTimeout.

	(listElement hasFocus not and: [ listElement isFocusable ]) ifTrue: [
		self terminateClickLauncherOnNode: node onEvent: anEvent.
		^ self ].

	" do not try double click if ctrl or Cmd or shift is pressed "
	(holder isSelected not or: [
		 anEvent sourceEvent modifiers isPrimaryModifier or: [
			 anEvent sourceEvent modifiers isShift ] ]) ifTrue: [
		self terminateClickLauncherOnNode: node onEvent: anEvent.
		^ aBlock value ].

	" Already have a click launcher "
	self hasClickLauncher ifTrue: [ ^ self ].

	" no click launcher for only one selected node "
	" Avoid selection size computation if all is selected "
	mode selectedIndexesCount > 0 ifFalse: [ ^ aBlock value ].

	self clickLauncher: ([
		 dblClickDelay asDelay wait.
		 aBlock value.
		 self clickLauncher: nil ]
			 forkAt: Processor lowIOPriority
			 named: self class name)
]

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> listClickOnNodeEvent: anEvent [

	| node |
	node := anEvent currentTarget.
	node holder listElement isMultipleSelection
		ifTrue: [ self multipleSelectionListClickOnNodeEvent: anEvent ]
		ifFalse: [ self singleSelectionListClickOnNodeEvent: anEvent ]
]

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> listClickOnNodeRequestEvent: aListClickOnNodeRequestEvent [

	| node |
	node := aListClickOnNodeRequestEvent currentTarget.
	node holder isSelectable ifFalse: [
		aListClickOnNodeRequestEvent deny ]
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> mouseDownEvent: anEvent [

	| node listElement |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	listElement isEnabled ifFalse: [ ^ self ].

	anEvent
		ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'multiple selection' }
ToListNodeSelectionEventHandler >> multipleSelectionListClickOnNodeEvent: anEvent [

	self launchClick: [ self onClickOnNodeEvent: anEvent ] event: anEvent
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> notifyClickOnNodeFromEvent: anEvent [

	| listElement node |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	listElement notifyClickOnNode: node fromEvent: anEvent
]

{ #category : #'selection events' }
ToListNodeSelectionEventHandler >> onClickOnNodeEvent: anEvent [

	| listElement node mode |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	mode := listElement primarySelectionMode.
	mode onClickEvent: anEvent onNode: node
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> pickEvent: anEvent [

	| node listElement mode |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	listElement isEnabled ifFalse: [ ^ self ].
	mode := listElement primarySelectionMode.
	mode selectOnPressed ifTrue: [ ^ self ].
	mode selectOnClick ifFalse: [ ^ self ].
	self notifyClickOnNodeFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> primaryMouseDownEvent: anEvent [

	| node listElement mode |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	mode := listElement primarySelectionMode.
	mode selectOnPressed ifFalse: [ ^ self ].
	self notifyClickOnNodeFromEvent: anEvent
]

{ #category : #'single selection' }
ToListNodeSelectionEventHandler >> singleSelectionListClickOnNodeEvent: anEvent [

	self onClickOnNodeEvent: anEvent
]

{ #category : #'multiple selection' }
ToListNodeSelectionEventHandler >> terminateClickLauncherOnNode: aNode onEvent: anEvent [

	clickLauncher ifNotNil: #terminate.
	clickLauncher := nil.
]
