Class {
	#name : #ToNodeEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'monitor',
		'target'
	],
	#category : 'Toplo-Widget-List-node'
}

{ #category : #'mouse handlers' }
ToNodeEventHandler >> clickEvent: anEvent [

	target := anEvent currentTarget.
	self
		launchClick: [
			target holder fireEvent: (ToClickOnNodeEvent new
					 holder: target holder;
					 event: anEvent;
					 yourself) ]
		event: anEvent
		for: target
]

{ #category : #'api - accessing' }
ToNodeEventHandler >> eventsToHandle [ 

	^ { ToNodeHolderSelectedEvent. ToNodeHolderDeselectedEvent. BlPrimaryClickEvent }
]

{ #category : #'events handling' }
ToNodeEventHandler >> launchClick: aBlock event: anEvent for: anElement [
	" click launcher management to allow double click to work with several selected nodes "

	| infinite |

	infinite := anElement holder infiniteElement.

	infinite hasOpenedContextMenu ifTrue: [
		infinite terminateClickLauncher.
		^ self ].

	infinite isFocused ifFalse: [
		infinite hasSelection ifTrue: [
			infinite preserveSelectionOnFocused ifTrue: [
				infinite requestFocus.
				^ self ] ] ].

	" do not try double click if ctrl or Cmd or shift is pressed "
	(anElement holder isSelected not or: [
		 anEvent modifiers isPrimaryModifier or: [
			 anEvent modifiers isShift ] ]) ifTrue: [
		infinite terminateClickLauncher.
		^ aBlock value ].


	" Already has a click launcher "
	infinite hasClickLauncher ifTrue: [ ^ self ].

	" no click launcher for only one selected node "
	infinite primarySelectionIndexes size > 1 ifFalse: [ ^ aBlock value ].

	monitor critical: [
		infinite clickLauncher: ([
			 (Delay forMilliseconds: 250) wait.
			 aBlock value.
			 infinite clickLauncher: nil ]
				 forkAt: Processor highIOPriority
				 named: 'ToNodeDresser clickLauncher') ]
]

{ #category : #'event handling' }
ToNodeEventHandler >> nodeHolderDeselectedEvent: anEvent [
]

{ #category : #'event handling' }
ToNodeEventHandler >> nodeHolderSelectedEvent: anEvent [

]

{ #category : #'api - hooks' }
ToNodeEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	monitor := Monitor new
]

{ #category : #'api - hooks' }
ToNodeEventHandler >> onUninstalledIn: anElement [

	monitor := nil.
	super onUninstalledIn: anElement.

]
