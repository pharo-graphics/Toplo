Class {
	#name : #ToMenuAsSubmenuDresser,
	#superclass : #ToDresser,
	#instVars : [
		'popupHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> defaultIconImage [

	^ BlElement new
		  size: 16 @ 16;
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c linear vertical alignCenter.
			  c linear horizontal alignCenter ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> installEventListenersIn: anElement [

	popupHandler := BlEventHandler
		                on: BlMouseEnterEvent
		                do: [ :event | self onEnterEvent: event in: anElement].
	anElement addEventHandler: popupHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> onEnterEvent: anEvent in: anElement [

	" check the event "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
		
	" ask the window which includes anElement to open the subwindow "
	anElement parentMenuWindow openSubmenuWindowFor: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement icon hasInnerImage ifFalse: [ 
		anElement iconImage: self defaultIconImage ].
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: popupHandler.


]
