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
	| pos |
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
	" the sub menu window must not be already opened "
	anElement menuWindow isAttachedToSceneGraph ifTrue: [ ^ self ].
	
	" do not open if empty "
	anElement items ifEmpty: [ ^ self ].
	
	" ok, open the sub menu window "
	anElement parentMenuWindow currentOpenedSubmenuWindow: anElement menuWindow.
	pos := anElement bounds inSpace bounds topRight.
	anElement menuWindow popupAtGlobalPosition: pos
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
