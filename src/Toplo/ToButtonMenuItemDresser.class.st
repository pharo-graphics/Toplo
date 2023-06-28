Class {
	#name : #ToButtonMenuItemDresser,
	#superclass : #ToGeneralButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'events handling' }
ToButtonMenuItemDresser >> up: anElement event: anEvent [

	| delay |
	super up: anElement event: anEvent.
	" check a minimal delay between opening and closing because 
	the mouse up can occur immediately if the menu is opened with 
	a button menu item placed under the mouse. This can be the case 
	if there is not enough place to open the menu at the default location and 
	if the menu position is changed accordingly
	"
	delay := anEvent timestamp - anElement parentMenuWindow popupTimestamp.
	delay > anElement parentMenuWindow autoCloseOnMouseUpDelay ifTrue: [
		anElement allParentMenusDo: [ :pm | pm menuWindow close ] ]
]
