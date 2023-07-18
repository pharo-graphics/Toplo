Class {
	#name : #ToWidgetSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'addedToSpace',
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

{ #category : #accessing }
ToWidgetSkin >> addedToSpace [

	^ addedToSpace 
]

{ #category : #'event handling' }
ToWidgetSkin >> elementAddedToSceneGraphEvent: anEvent [

	addedToSpace ifTrue: [ ^ self ].
	self whenAddedToSpace: anEvent in: anEvent currentTarget.
	addedToSpace := true
]

{ #category : #'event handling' }
ToWidgetSkin >> elementLookEvent: anEvent [
	" has to be redefined in subclasses to manage element children (to dispatch look event to them)"

	anEvent sendTo: self look.
	(self subElementsIn: anEvent target) do: [ :e |
		e dispatchEvent: anEvent clone ]
]

{ #category : #'event handling' }
ToWidgetSkin >> elementRemovedFromSceneGraphEvent: anEvent [

	addedToSpace ifFalse: [ ^ self ].
	self whenRemovedFromSpace:  anEvent in: anEvent currentTarget.
	addedToSpace := false
]

{ #category : #'api - accessing' }
ToWidgetSkin >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent. BlElementRemovedFromSceneGraphEvent. ToElementLookEvent }
]

{ #category : #initialization }
ToWidgetSkin >> initialize [ 

	super initialize.
	addedToSpace := false.
]

{ #category : #accessing }
ToWidgetSkin >> look [

	^ look
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self privateLook: ToNullElementLook new.
	"addedToSpace := anElement isAttachedToSceneGraph."
	"addedToSpace
		ifTrue: [ self whenAddedToSpace: nil in: anElement ]
		ifFalse: [ self whenRemovedFromSpace: nil in: anElement ]"
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

{ #category : #accessing }
ToWidgetSkin >> subElementsIn: anElement [

	^ {  }
]

{ #category : #'event handling' }
ToWidgetSkin >> themeChangedEvent: anEvent [

	self whenRemovedFromSpace: anEvent in: anEvent currentTarget.
	self whenAddedToSpace: anEvent in: anEvent currentTarget
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> whenAddedToSpace: anEvent in: anElement [

	anElement whenLayoutedDoOnce: [
		anElement dispatchEvent: (ToInstallLookEvent new copyFrom: anEvent).
		anElement dispatchEvent:	((ToElementStateChangedEvent new state: ToInitialState new)
				 copyFrom: anEvent) ]
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> whenRemovedFromSpace: anEvent in: anElement [

	anElement dispatchEvent: (ToUninstallLookEvent new copyFrom: anEvent)
]
