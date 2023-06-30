Class {
	#name : #ToMenuAsSubmenuDresser,
	#superclass : #ToMouseHandlingDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> hover: anElement event: anEvent [

	super hover: anElement event: anEvent. 

	" check the event "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
		
	" ask the window which includes anElement to open the subwindow "
	anElement parentMenuWindow openSubmenuWindowFor: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> leaved: anElement event: anEvent [
	" do not ask to close the menu window here because the mouse 
	can enter the submenu window here (which should not be closed)"

	super leaved: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement strategy: (ToPairSubmenuColumnStrategy new width: anElement columnWidth)
]
