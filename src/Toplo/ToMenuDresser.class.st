Class {
	#name : #ToMenuDresser,
	#superclass : #ToMenuItemDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> clickedIn: aMenuItem [

	super clickedIn: aMenuItem
	" redifined to not close the menu window"
]
