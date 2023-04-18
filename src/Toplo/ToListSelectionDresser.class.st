Class {
	#name : #ToListSelectionDresser,
	#superclass : #ToDresser,
	#instVars : [
		'listElement',
		'addedToParentHandler',
		'removedFromParentHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSelectionDresser >> borderColor [

	^ Color gray
]

{ #category : #accessing }
ToListSelectionDresser >> borderWidth [

	^ 1
]

{ #category : #initialization }
ToListSelectionDresser >> defaultBorder [

	^ BlBorder paint: self borderColor width: self borderWidth
]

{ #category : #initialization }
ToListSelectionDresser >> defaultPadding [

	^ BlInsets all: 0
]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAddedToParent: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemovedFromParent: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler.

]

{ #category : #accessing }
ToListSelectionDresser >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListSelectionDresser >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement padding: self defaultPadding.
	anElement border:	self defaultBorder.


]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: addedToParentHandler.
	anElement removeEventHandler: removedFromParentHandler.
	addedToParentHandler := nil.
	removedFromParentHandler := nil.
	
	super uninstallEventListenersIn: anElement.


]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionDresser >> whenAddedToParent: anElement [

	listElement := anElement listElement.
]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionDresser >> whenRemovedFromParent: anElement [

	listElement := nil
]
