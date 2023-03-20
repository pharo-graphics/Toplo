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

	^ BlInsets all: 1
]

{ #category : #initialization }
ToListElementDresser >> defaultPadding [

	^ BlInsets all: 1

]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> installEventListenersIn: anElement [

	keyboardHandler := BlEventHandler on: BlKeyboardEvent do: [ :event | anElement infinite dispatchEvent: event ].	
	anElement addEventHandler: keyboardHandler

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
