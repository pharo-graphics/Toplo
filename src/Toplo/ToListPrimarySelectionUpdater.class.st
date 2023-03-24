Class {
	#name : #ToListPrimarySelectionUpdater,
	#superclass : #ToListNodesDecorationUpdater,
	#instVars : [
		'selectionHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #testing }
ToListPrimarySelectionUpdater >> includesNode: aNode [

	^ aNode holder isSelected
]

{ #category : #'instance creation' }
ToListPrimarySelectionUpdater >> newDecorationElement [

	^ ToListPrimarySelectionElement new
]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	selectionHandler := BlEventHandler on: ToInfiniteSelectionChangedEvent do: [ self selectionChangedIn: aListElement ].
	aListElement infinite addEventHandler: selectionHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	aListElement infinite removeEventHandler: selectionHandler.

]
