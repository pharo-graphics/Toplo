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

	aListElement when: ToListSelectionUpdaterStopEvent do: [ :event | listElement = event target ifTrue: [ self onUninstalledIn: listElement ] ].

	secondarySelectionAddedHandler := BlEventHandler
		                                  on: ToListSecondarySelectionAddedEvent
		                                  do: [ :event | self showSecondaryDecoration ].
	secondarySelectionRemovedHandler := BlEventHandler
		                                    on: ToListSecondarySelectionRemovedEvent
		                                    do: [ :event | self hideSecondaryDecoration ].
	primarySelectionUpdateHandler := BlEventHandler
		                                 on: ToListPrimarySelectionUpdateEvent
		                                 do: [ :event | self selectionChangedIn: aListElement ].
	selectionModelHandler := BlEventHandler
		                         on: ToInfiniteSelectionChangedEvent
		                         do: [ self selectionChangedIn: aListElement ].

	aListElement addEventHandler: secondarySelectionRemovedHandler.
	aListElement addEventHandler: primarySelectionUpdateHandler.
	aListElement addEventHandler: secondarySelectionAddedHandler.
	aListElement infinite addEventHandler: selectionModelHandler.
]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	aListElement removeEventHandler: secondarySelectionRemovedHandler.
	aListElement removeEventHandler: primarySelectionUpdateHandler.
	aListElement removeEventHandler: secondarySelectionAddedHandler.
	aListElement infinite removeEventHandler: selectionModelHandler

]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionUpdater >> showSecondaryDecoration [

	self decorations do: [ :d | d beWithSecondarySelection ]
]
