Class {
	#name : #ToMenuWindowModelDresser,
	#superclass : #ToMouseHandlingDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> leftPressed: anElement event: anEvent [

	self popupOrClose: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> popupOrClose: anElement event: anEvent [

	anElement menuWindow isAttachedToSceneGraph ifTrue: [ 
		anElement isSubmenu ifTrue: [ ^ anElement parentMenu menuWindow close ].
		^ anElement menuWindow close ].
	anElement menuWindow popupEvent: anEvent
]
