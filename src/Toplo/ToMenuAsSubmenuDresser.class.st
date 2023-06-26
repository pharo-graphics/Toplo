Class {
	#name : #ToMenuAsSubmenuDresser,
	#superclass : #ToDresser,
	#instVars : [
		'enterHandler',
		'leaveHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> installEventListenersIn: anElement [

	enterHandler := BlEventHandler
		                on: BlMouseEnterEvent
		                do: [ :event | self onEnterEvent: event in: anElement].
	leaveHandler := BlEventHandler
		                on: BlMouseLeaveEvent
		                do: [ :event | self onLeaveEvent: event in: anElement].
	anElement addEventHandler: enterHandler.
	anElement addEventHandler: leaveHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> onEnterEvent: anEvent in: anElement [

	" check the event "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
		
	" ask the window which includes anElement to open the subwindow "
	anElement parentMenuWindow openSubmenuWindowFor: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement strategy: (ToPairSubmenuColumnStrategy new width: anElement columnWidth)
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> onLeaveEvent: anEvent in: anElement [
		
	" do not ask to close the menu window here because the mouse can enter the submenu window here (which should not be closed)"
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: enterHandler.
	anElement removeEventHandler: leaveHandler

]
