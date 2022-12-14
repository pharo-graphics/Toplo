Class {
	#name : #ToMenuItemDresser,
	#superclass : #ToButtonDresser,
	#instVars : [
		'otherWindowClickHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuItemDresser >> clickedIn: aMenuItem [

	aMenuItem parentMenuWindow ifNil: [ ^ self ].
	"aMenuItem parentMenuWindow close "
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	otherWindowClickHandler := BlEventHandler
		                          on: BlMouseEnterEvent
		                          do: [ :event | self onEnterEvent: event in: anElement].
	anElement addEventHandler: otherWindowClickHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemDresser >> onEnterEvent: anEvent in: anElement [

	| parentWindow |
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].

	" the element is visible in a window "
	anElement parentMenuWindow ifNil: [ ^ self ].
	parentWindow := anElement parentMenuWindow.

	" a submenu is opened "
	parentWindow currentOpenedSubmenuWindow ifNil: [ ^ self ].

	" the submenu is not mine "
	parentWindow currentOpenedSubmenuWindow == anElement menuWindow 
		ifTrue: [ ^ self ].

	" ok, I can close other item submenu window"
	parentWindow currentOpenedSubmenuWindow close.
	parentWindow currentOpenedSubmenuWindow: nil
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement background: Color transparent.
	anElement border:  (BlBorder empty).
	anElement padding: (BlInsets all: 0).
	anElement layout cellSpacing: 4.
	anElement whenClickedDo: [ :anEvent |  ]

]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: otherWindowClickHandler
]
