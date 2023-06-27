Class {
	#name : #ToMenuWindowModelDresser,
	#superclass : #ToDresser,
	#instVars : [
		'clickHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	clickHandler := BlEventHandler on: BlMouseDownEvent do: [ :event | self popupOrClose: anElement event: event].
	anElement addEventHandler: clickHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: clickHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> popupOrClose: anElement event: anEvent [

	anElement subMenuWindow isAttachedToSceneGraph ifTrue: [ 
		anElement isSubmenu ifTrue: [ ^ anElement parentMenu subMenuWindow close ].
		^ anElement subMenuWindow close ].
	anElement subMenuWindow popupEvent: anEvent
]
