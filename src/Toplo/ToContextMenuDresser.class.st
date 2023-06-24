Class {
	#name : #ToContextMenuDresser,
	#superclass : #ToMenuWindowDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
]

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> mouseDownOutside: anEvent receivedIn: aMenuWindow [

	" decide  if one have to close the window "

	anEvent currentTarget close
]

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
]
