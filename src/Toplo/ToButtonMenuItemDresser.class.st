Class {
	#name : #ToButtonMenuItemDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonMenuItemDresser >> clicked: anElement [

	super clicked: anElement.
	anElement parentMenuWindow close
]

{ #category : #'api - install/uninstall  hook' }
ToButtonMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement icon padding: (BlInsets left: 2 right: 2).
	anElement label padding: (BlInsets left: 2 right: 2)
]
