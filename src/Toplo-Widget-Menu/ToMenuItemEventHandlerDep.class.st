Class {
	#name : #ToMenuItemEventHandlerDep,
	#superclass : #ToPopupWindowAssociateElementEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandlerDep >> mouseEnterEvent: anEvent [

	self switchToHoveredState.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ]) 
		ifTrue: [ ^ self ].
	" normally the element is visible in a window "
	target parentMenuWindow ifNil: [ ^ self ].

	" ask the window to react "

	" test if a submenu is opened "
	target parentMenuWindow  openedSubmenuWindow ifNil: [ ^ self ].

	" test if the submenu is not the menuItem one "
	target parentMenuWindow  openedSubmenuWindow == target window 
		ifTrue: [ ^ self ].

	" ok, I can close other item submenu window"
	target parentMenuWindow  openedSubmenuWindow close.
	target parentMenuWindow  openedSubmenuWindow: nil
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandlerDep >> mouseLeaveEvent: anEvent [

	self switchToLeavedState.
	self switchToInitialState 

]

{ #category : #'mouse handlers' }
ToMenuItemEventHandlerDep >> mouseUpEvent: anEvent [ 

	"| delay |
	super mouseUpEvent: anEvent.
	"" check a minimal delay between opening and closing because 
	the mouse up can occur immediately if the menu is opened with 
	a button menu item placed under the mouse. This can be the case 
	if there is not enough place to open the menu at the default location and 
	if the menu position is changed accordingly.
	If the delay is short, then the event is consumed to avoid unwanted menu item action invocation.
	""
	target parentMenuWindow ifNil: [ ^ self ].
	delay := anEvent timestamp - target parentMenuWindow popupTimestamp.
	delay > target parentMenuWindow autoCloseOnMouseUpDelay
		ifTrue: [ target allParentMenusDo: [ :pm | pm close ] ]
		ifFalse: [ anEvent consumed: true ]"
]
