Class {
	#name : #ToMenuAsSubmenuDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> hover: anElement event: anEvent [

	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith:
			'`@receiver hover: `@anElement event: `@anEvent'
				-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
	super hover: anElement event: anEvent. 

	" check the event "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
		
	" ask the window which includes anElement to open the subwindow "
	anElement parentMenuWindow openSubmenuWindowFor: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> leaved: anElement event: anEvent [
	" do not ask to close the menu window here because the mouse 
	can enter the submenu window here (which should not be closed)"

	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith:
			'`@receiver leaved: `@anElement event: `@anEvent'
				-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.
	super leaved: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> mouseEnterEvent: anEvent in: anElement [


	super mouseEnterEvent: anEvent in: anElement.

	" check the event "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
		
	" ask the window which includes anElement to open the subwindow "
	anElement parentMenuWindow openSubmenuWindowFor: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuAsSubmenuDresser >> mouseLeaveEvent: anEvent in: anElement [
	" do not ask to close the menu window here because the mouse 
	can enter the submenu window here (which should not be closed)"

	super mouseLeaveEvent: anEvent in: anElement
]
