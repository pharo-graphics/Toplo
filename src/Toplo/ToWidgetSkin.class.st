Class {
	#name : #ToWidgetSkin,
	#superclass : #ToCompanion,
	#instVars : [
		'lookEventHandler'
	],
	#category : #'Toplo-Theme-Skins'
}

{ #category : #adding }
ToWidgetSkin >> addLook: aLook [

	self lookEventHandler addLook: aLook
]

{ #category : #accessing }
ToWidgetSkin >> lookEventHandler [

	^ lookEventHandler
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> mainLookIn: anElement [

	^ anElement defaultLook.

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	lookEventHandler := ToElementLookEventHandler new.
	anElement addEventHandler: lookEventHandler.
	
	self addLook: (self mainLookIn: anElement).

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: lookEventHandler.
	lookEventHandler := nil.

]

{ #category : #adding }
ToWidgetSkin >> removeLook: aLook [

	self lookEventHandler removeLook: aLook
]
