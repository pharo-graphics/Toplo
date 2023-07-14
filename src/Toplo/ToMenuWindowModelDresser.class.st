Class {
	#name : #ToMenuWindowModelDresser,
	#superclass : #ToMouseHandlingDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> leftMouseDownEvent: anEvent in: anElement [

	super leftMouseDownEvent: anEvent in: anElement.
	self popupOrClose: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> leftPressed: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver leftPressed: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseDownEvent: `@anEvent in: `@anElement'.
	self popupOrClose: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> popupOrClose: anElement event: anEvent [

	anElement menuWindow isAttachedToSceneGraph ifTrue: [ 
		anElement isSubmenu ifTrue: [ ^ anElement parentMenu menuWindow close ].
		^ anElement menuWindow close ].
	anElement menuWindow popupEvent: anEvent
]
