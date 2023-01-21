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
	clickHandler := BlEventHandler on: BlClickEvent do: [ self popupOrClose: anElement ].
	anElement addEventHandler: clickHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: clickHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowModelDresser >> popupOrClose: anElement [

	anElement subMenuWindow isAttachedToSceneGraph ifTrue: [ 
		^ anElement subMenuWindow close ].
	anElement parentMenuWindow ifNotNil: [ :w | 
		^ w openSubmenuWindowFor: anElement ].
	anElement subMenuWindow popup
]
