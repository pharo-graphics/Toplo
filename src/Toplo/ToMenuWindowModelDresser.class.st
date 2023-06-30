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

	anElement subMenuWindow isAttachedToSceneGraph ifTrue: [ 
		^ anElement subMenuWindow close ].
	anElement subMenuWindow popupEvent: anEvent
]
