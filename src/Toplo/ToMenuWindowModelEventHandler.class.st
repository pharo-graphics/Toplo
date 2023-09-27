Class {
	#name : #ToMenuWindowModelEventHandler,
	#superclass : #ToMenuItemEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'mouse handlers' }
ToMenuWindowModelEventHandler >> leftMouseDownEvent: anEvent [

	super leftMouseDownEvent: anEvent.
	privateTarget menuWindow isAttachedToSceneGraph ifTrue: [
		privateTarget isSubmenu ifTrue: [ ^ privateTarget parentMenu close ].
		^ privateTarget close ].
	privateTarget popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuWindowModelEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	privateTarget isSubmenu ifFalse: [ ^ self ].
	
	" check the event "
	(anEvent anyButtonPressed and: [
		 anEvent currentTarget ~= privateTarget ]) ifTrue: [ ^ self ].

	" ask the window which includes the target to open the subwindow "
	privateTarget parentMenuWindow
		openSubmenuWindowFor: privateTarget
		event: anEvent
]
