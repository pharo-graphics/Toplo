Class {
	#name : #ToMenuDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement icon padding: (BlInsets left: 2 right: 2).
	anElement label padding: (BlInsets left: 2 right: 2)

]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]
