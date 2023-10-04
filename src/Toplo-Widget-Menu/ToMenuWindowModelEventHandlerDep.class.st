Class {
	#name : #ToMenuWindowModelEventHandlerDep,
	#superclass : #ToMenuItemEventHandlerDep,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuWindowModelEventHandlerDep >> leftMouseDownEvent: anEvent [

	super leftMouseDownEvent: anEvent.
	target menuWindow isOpened ifTrue: [
		target isSubmenu ifTrue: [ ^ target parentMenu close ].
		^ target close ].
	target popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuWindowModelEventHandlerDep >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	target isSubmenu ifFalse: [ ^ self ].
	
	" check the event "
	(anEvent anyButtonPressed and: [
		 anEvent currentTarget ~= target ]) ifTrue: [ ^ self ].

	" ask the window which includes the target to open the subwindow "
	target parentMenuWindow
		openSubmenuWindowFor: target
		event: anEvent
]
