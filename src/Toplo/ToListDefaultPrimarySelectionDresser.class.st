Class {
	#name : #ToListDefaultPrimarySelectionDresser,
	#superclass : #ToListPrimarySelectionDresser,
	#instVars : [
		'backgroundElement'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> blurEvent: anEvent in: anElement [

	super blurEvent: anEvent in: anElement.
	backgroundElement background: self theme item selectedBlurredColor.
	self background: backgroundElement background changedIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> focusEvent: anEvent in: anElement [

	super focusEvent: anEvent in: anElement.
	backgroundElement background: self theme item selectedColor.
	self background: backgroundElement background changedIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> secondarySelectionAddedIn: anElement [

	super secondarySelectionAddedIn: anElement.
	anElement padding: (BlInsets all: 3)
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> secondarySelectionRemovedIn: anElement [

	super secondarySelectionRemovedIn: anElement.
	anElement padding: (BlInsets all: 0)
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> whenAdded: anElement [

	super whenAdded: anElement.

	backgroundElement := ToElement new matchParent.
	anElement background: Color transparent.
	backgroundElement background: self theme item selectedColor.
	anElement addChild: backgroundElement.
	
	self background: backgroundElement background changedIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> whenRemoved: anElement [

	anElement removeChild: backgroundElement.
	backgroundElement := nil.
	super whenRemoved: anElement
]
