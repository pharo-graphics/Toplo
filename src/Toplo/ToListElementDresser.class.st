Class {
	#name : #ToListElementDresser,
	#superclass : #ToDresser,
	#instVars : [
		'keyboardHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListElementDresser >> defaultBackground [

	^ BlBackground paint: Color white
]

{ #category : #initialization }
ToListElementDresser >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListElementDresser >> defaultPadding [

	^ BlInsets all: 0

]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> installEventListenersIn: anElement [

	keyboardHandler := BlEventHandler
		                   on: BlKeyboardEvent
		                   do: [ :event |
		                   anElement infinite dispatchEvent: event ].
	anElement addEventHandler: keyboardHandler.

	anElement infinite when: BlBlurEvent do: [ :anEvent |
		anElement updateSelectionBackground: anElement blurSelectedItemBackground  ].
	anElement infinite when: BlFocusEvent do: [ :anEvent |
		anElement updateSelectionBackground:
			anElement selectedItemBackground ]
]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: self defaultBackground.
	anElement margin: self defaultMargin.
	anElement padding: self defaultPadding.
	
	self installEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	
	self uninstallEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: keyboardHandler

]
