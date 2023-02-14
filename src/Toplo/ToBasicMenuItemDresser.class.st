Class {
	#name : #ToBasicMenuItemDresser,
	#superclass : #ToDresser,
	#instVars : [
		'enterHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> installEventListenersIn: anElement [

	enterHandler := BlEventHandler
		                          on: BlMouseEnterEvent
		                          do: [ :event | self onEnterEvent: event in: anElement].
	anElement addEventHandler: enterHandler
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> onEnterEvent: anEvent in: anElement [

	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
	" normally the element is visible in a window "
	anElement parentMenuWindow ifNil: [ ^ self ].
	" ask the window to react "
	anElement parentMenuWindow mouseEnterOnMenuItem: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: Color transparent.
	anElement border: BlBorder empty.
	anElement padding: (BlInsets top: 2 left: 5 bottom: 2 right: 4 ).
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement.
	

]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: enterHandler
]
