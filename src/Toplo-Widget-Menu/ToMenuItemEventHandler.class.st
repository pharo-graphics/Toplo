Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #ToSkinableEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	self switchToHoveredState.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= privateTarget ]) 
		ifTrue: [ ^ self ].
	" normally the element is visible in a window "
	privateTarget parentMenuWindow ifNil: [ ^ self ].
	" ask the window to react "
	privateTarget parentMenuWindow mouseEnterOnMenuItem: privateTarget
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseLeaveEvent: anEvent [

	self switchToLeavedState.
	self switchToInitialState 

]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseUpEvent: anEvent [ 

	| delay |
	super mouseUpEvent: anEvent.
	" check a minimal delay between opening and closing because 
	the mouse up can occur immediately if the menu is opened with 
	a button menu item placed under the mouse. This can be the case 
	if there is not enough place to open the menu at the default location and 
	if the menu position is changed accordingly.
	If the delay is short, then the event is consumed to avoid unwanted menu item action invocation.
	"
	privateTarget parentMenuWindow ifNil: [ ^ self ].
	delay := anEvent timestamp - privateTarget parentMenuWindow popupTimestamp.
	delay > privateTarget parentMenuWindow autoCloseOnMouseUpDelay
		ifTrue: [ privateTarget allParentMenusDo: [ :pm | pm close ] ]
		ifFalse: [ anEvent consumed: true ]
]
