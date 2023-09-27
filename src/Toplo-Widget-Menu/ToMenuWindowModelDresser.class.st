Class {
	#name : #ToMenuWindowModelDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #testing }
ToMenuWindowModelDresser class >> isDeprecated [ 

	^ true
]

{ #category : #'events handling' }
ToMenuWindowModelDresser >> leftMouseDownEvent: anEvent in: anElement [

	super leftMouseDownEvent: anEvent in: anElement.
	self popupOrClose: anElement event: anEvent
]

{ #category : #'events handling' }
ToMenuWindowModelDresser >> popupOrClose: anElement event: anEvent [

	anElement menuWindow isAttachedToSceneGraph ifTrue: [
		anElement isSubmenu ifTrue: [ ^ anElement parentMenu close ].
		^ anElement close ].
	anElement popupEvent: anEvent
]
