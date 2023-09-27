Class {
	#name : #ToBasicMenuItemDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #testing }
ToBasicMenuItemDresser class >> isDeprecated [ 

	^ true
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> hover: anElement event: anEvent [

	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith:
			'`@receiver hover: `@anElement event: `@anEvent'
				-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.

	super hover: anElement event: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
	" normally the element is visible in a window "
	anElement parentMenuWindow ifNil: [ ^ self ].
	" ask the window to react "
	anElement parentMenuWindow mouseEnterOnMenuItem: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> mouseEnterEvent: anEvent in: anElement [

	" don't send to super since the default behavior is o do nothing if a button is pressed "
	self hoveredState: anElement.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
	" normally the element is visible in a window "
	anElement parentMenuWindow ifNil: [ ^ self ].
	" ask the window to react "
	anElement parentMenuWindow mouseEnterOnMenuItem: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> mouseLeaveEvent: anEvent in: anElement [

	" don't send to super since the default behavior is o do nothing if a button is pressed "
	self leaved: anElement.
	self initialState: anElement
]
