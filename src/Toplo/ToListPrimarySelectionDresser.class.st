Class {
	#name : #ToListPrimarySelectionDresser,
	#superclass : #ToListSelectionDresser,
	#instVars : [
		'secondarySelectionAddedHandler',
		'secondarySelectionRemovedHandler',
		'blurHandler',
		'focusHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionDresser >> blurEvent: anEvent in: anElement [
]

{ #category : #accessing }
ToListPrimarySelectionDresser >> borderWidth [ 

	^ 1
]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionDresser >> focusEvent: anEvent in: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionDresser >> secondarySelectionAddedIn: anElement [
]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionDresser >> secondarySelectionRemovedIn: anElement [
]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionDresser >> whenAddedToParent: anElement [

	super whenAddedToParent: anElement.
	secondarySelectionAddedHandler := BlEventHandler
		                                  on: ToListSecondarySelectionAddedEvent
		                                  do: [ :event | self secondarySelectionAddedIn: anElement ].
	secondarySelectionRemovedHandler := BlEventHandler
		                                    on: ToListSecondarySelectionRemovedEvent
		                                    do: [ :event | self secondarySelectionRemovedIn: anElement ].

	listElement addEventHandler: secondarySelectionAddedHandler.
	listElement addEventHandler: secondarySelectionRemovedHandler.
	
	blurHandler := BlEventHandler
		               on: BlBlurEvent
		               do: [ :anEvent | self blurEvent: anEvent in: anElement ].
	focusHandler := BlEventHandler
		                on: BlFocusEvent
		                do: [ :anEvent | self focusEvent: anEvent in: anElement ].

	listElement infinite addEventHandler: blurHandler.
	listElement infinite addEventHandler: focusHandler


]

{ #category : #'api - install/uninstall  hook' }
ToListPrimarySelectionDresser >> whenRemovedFromParent: anElement [

	anElement nodesDo: [ :node | node dispatchEvent: ToListPrimarySelectionRemovedEvent new ].

	listElement removeEventHandler: secondarySelectionAddedHandler.
	listElement removeEventHandler: secondarySelectionRemovedHandler.

	listElement infinite removeEventHandler: blurHandler.
	listElement infinite removeEventHandler: focusHandler.
	
	secondarySelectionAddedHandler := nil.
	secondarySelectionRemovedHandler := nil.
	blurHandler := nil.
	focusHandler := nil.

	super whenRemovedFromParent: anElement.

	

]
