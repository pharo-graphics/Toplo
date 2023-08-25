Class {
	#name : #ToButtonMenuItemDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'events handling' }
ToButtonMenuItemDresser >> mouseUpEvent: anEvent in: anElement [

	| delay |
	super mouseUpEvent: anEvent in: anElement.
	" check a minimal delay between opening and closing because 
	the mouse up can occur immediately if the menu is opened with 
	a button menu item placed under the mouse. This can be the case 
	if there is not enough place to open the menu at the default location and 
	if the menu position is changed accordingly.
	If the delay is short, then the event is consumed to avoid unwanted menu item action invocation.
	"
	delay := anEvent timestamp - anElement parentMenuWindow popupTimestamp.
	delay > anElement parentMenuWindow autoCloseOnMouseUpDelay
		ifTrue: [ anElement allParentMenusDo: [ :pm | pm close ] ]
		ifFalse: [ anEvent consumed: true ]
]
