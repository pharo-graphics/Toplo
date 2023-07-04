Class {
	#name : #ToListSelectionDresser,
	#superclass : #ToDresser,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #dressing }
ToListSelectionDresser >> background: aBackground changedIn: anElement [

	anElement nodesDo: [ :node |
		node dispatchEvent: (ToListPrimarySelectionBackgroundChangedEvent new
				 background: aBackground;
				 yourself) ]
]

{ #category : #accessing }
ToListSelectionDresser >> borderColor [

	^ Color gray
]

{ #category : #accessing }
ToListSelectionDresser >> borderWidth [

	^ 0
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

	super installEventListenersIn: anElement
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

	super uninstallEventListenersIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionDresser >> whenAdded: anElement [

	super whenAdded: anElement.
	listElement := anElement listElement.

]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionDresser >> whenRemoved: anElement [

	listElement := nil.
	super whenRemoved: anElement.

]
