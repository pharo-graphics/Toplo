Class {
	#name : #ToBasicMenuItemDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-Menu'
}

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

	super mouseEnterEvent: anEvent in: anElement.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
	" normally the element is visible in a window "
	anElement parentMenuWindow ifNil: [ ^ self ].
	" ask the window to react "
	anElement parentMenuWindow mouseEnterOnMenuItem: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: Color transparent.
	anElement border: BlBorder empty.
	anElement padding: (BlInsets top: 0 left: 5 bottom: 0 right: 4 )
]
