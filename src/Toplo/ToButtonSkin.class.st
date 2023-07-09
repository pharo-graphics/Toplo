Class {
	#name : #ToButtonSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'iconChangeHandler',
		'labelChangeHandler'
	],
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'instance creation' }
ToButtonSkin >> iconChanged: aToButtonIconChangedEvent [

	self subclassResponsibility 
]

{ #category : #'instance creation' }
ToButtonSkin >> labelChanged: aToButtonLabelChangedEvent [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	iconChangeHandler := BlEventHandler on: ToButtonIconChanged do: [ :evt | self iconChanged: evt ].
	labelChangeHandler := BlEventHandler on: ToButtonLabelChanged do: [ :evt | self labelChanged: evt ].
	anElement addEventHandler: iconChangeHandler.
	anElement addEventHandler: labelChangeHandler

]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: iconChangeHandler.
	anElement removeEventHandler: labelChangeHandler

]
