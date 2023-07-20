Class {
	#name : #ToWidgetSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'look'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #adding }
ToWidgetSkin >> addLook: aLook [

	aLook isNull ifTrue: [ ^ self ].
	aLook next: look.
	self privateLook: aLook
]

{ #category : #'as yet unclassified' }
ToWidgetSkin >> elementAddedToSceneGraphEvent: anEvent [

	self whenAddedToSpace: anEvent in: anEvent currentTarget
]

{ #category : #'event handling' }
ToWidgetSkin >> elementLookEvent: anEvent [

	anEvent sendTo: self look
]

{ #category : #'as yet unclassified' }
ToWidgetSkin >> elementRemovedFromSceneGraphEvent: anEvent [

	self whenRemovedFromSpace: anEvent in: anEvent currentTarget
]

{ #category : #'event handling' }
ToWidgetSkin >> elementSkinChangedEvent: anEvent [

	
]

{ #category : #'api - accessing' }
ToWidgetSkin >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent. BlElementRemovedFromSceneGraphEvent . ToElementLookEvent }
]

{ #category : #accessing }
ToWidgetSkin >> look [

	^ look
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self privateLook: ToNullElementLook new.
	
	
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onSkinInstalledIn: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onSkinUninstalledIn: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onUninstalledIn: anElement [

	look := nil.
	super onUninstalledIn: anElement
]

{ #category : #'private - accessing' }
ToWidgetSkin >> privateLook: aLook [

	look := aLook
]

{ #category : #removing }
ToWidgetSkin >> removeLook: aLook [

	look = aLook 
		ifTrue: [ look := look next ]
		ifFalse: [ look removeLook: aLook previous: nil ]
]

{ #category : #'event handling' }
ToWidgetSkin >> themeChangedEvent: anEvent [

	self onSkinUninstalledIn: anEvent currentTarget.
	self onSkinInstalledIn: anEvent currentTarget.
	anEvent currentTarget dispatchLookEvent: ToInstallLookEvent new.
	anEvent currentTarget whenLayoutedDoOnce: [ anEvent currentTarget switchToState: ToInitialState new ]
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> whenAddedToSpace: anEvent in: anElement [

	self onSkinInstalledIn: anElement.
	anElement dispatchLookEvent: ToInstallLookEvent new.
	anElement whenLayoutedDoOnce: [ anElement switchToState: ToInitialState new ]
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> whenRemovedFromSpace: anEvent in: anElement [

	anElement dispatchLookEvent: ToUninstallLookEvent new.
	self onSkinUninstalledIn: anElement.

]
