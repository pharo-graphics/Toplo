Class {
	#name : #ToListPrimarySelectionUpdater,
	#superclass : #ToListNodesDecorationUpdater,
	#instVars : [
		'selectionModelHandler',
		'primarySelectionUpdateHandler',
		'secondarySelectionAddedHandler',
		'secondarySelectionRemovedHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> hideSecondaryDecoration [

	self decorations do: [ :d | d beWithoutSecondarySelection ]
]

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

	secondarySelectionAddedHandler := BlEventHandler
		                                    on: ToListSecondarySelectionAddedEvent
		                                    do: [ :event | self showSecondaryDecoration ].
	aListElement addEventHandler: secondarySelectionAddedHandler.
	secondarySelectionRemovedHandler := BlEventHandler
		                                    on: ToListSecondarySelectionRemovedEvent
		                                    do: [ :event | self hideSecondaryDecoration ].
	aListElement addEventHandler: secondarySelectionRemovedHandler.
	
	primarySelectionUpdateHandler := BlEventHandler on: ToListPrimarySelectionUpdateEvent do: [ :event | self selectionChangedIn: aListElement  ].
	aListElement addEventHandler: primarySelectionUpdateHandler.
	
	selectionModelHandler := BlEventHandler
		                    on: ToInfiniteSelectionChangedEvent
		                    do: [ self selectionChangedIn: aListElement ].
	aListElement infinite addEventHandler: selectionModelHandler
]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	aListElement infinite removeEventHandler: selectionModelHandler.
	aListElement removeEventHandler: secondarySelectionAddedHandler.
	aListElement removeEventHandler: primarySelectionUpdateHandler.


]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> showSecondaryDecoration [

	self decorations do: [ :d | d beWithSecondarySelection ]
]
