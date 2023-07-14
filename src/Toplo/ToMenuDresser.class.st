Class {
	#name : #ToMenuDresser,
	#superclass : #ToGeneralButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement fitContent
]
