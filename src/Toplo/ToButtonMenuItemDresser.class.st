Class {
	#name : #ToButtonMenuItemDresser,
	#superclass : #ToMenuItemDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonMenuItemDresser >> clicked: anElement [

	super clicked: anElement.
	anElement parentMenuWindow close
]
