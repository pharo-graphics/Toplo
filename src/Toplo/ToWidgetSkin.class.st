Class {
	#name : #ToWidgetSkin,
	#superclass : #Object,
	#instVars : [
		'lookEventHandler',
		'addedToSpaceHandler',
		'removedFromSpaceHandler',
		'addedToSpace'
	],
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #adding }
ToWidgetSkin >> addLook: aLook [

	self lookEventHandler addLook: aLook
]

{ #category : #accessing }
ToWidgetSkin >> addedToSpace [

	^ addedToSpace ifNil: [ addedToSpace := false ]
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> installEventListenersIn: anElement [

	addedToSpaceHandler := BlEventHandler
		                        on: BlElementAddedToSceneGraphEvent 
		                        do: [ :event | self sendWhenAddedToSpace: event in: anElement ].
	removedFromSpaceHandler := BlEventHandler
		                        on: BlElementRemovedFromSceneGraphEvent
		                        do: [  :event | self sendWhenRemovedFromSpace: event in: anElement ].

	anElement addEventHandler: addedToSpaceHandler.
	anElement addEventHandler: removedFromSpaceHandler
]

{ #category : #accessing }
ToWidgetSkin >> lookEventHandler [

	^ lookEventHandler
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onInstalledIn: anElement [

	lookEventHandler := ToElementLookEventHandler new.
	anElement addEventHandler: lookEventHandler.
	self installEventListenersIn: anElement.
	anElement isAttachedToSceneGraph 
		ifTrue: [ self sendWhenAddedToSpace: nil in: anElement ]
		ifFalse: [ self sendWhenRemovedFromSpace: nil in: anElement ].


]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> onUninstalledIn: anElement [

	anElement removeEventHandler: lookEventHandler.
	lookEventHandler := nil.
	self uninstallEventListenersIn: anElement


]

{ #category : #adding }
ToWidgetSkin >> removeLook: aLook [

	self lookEventHandler removeLook: aLook
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> sendWhenAddedToSpace: anEvent in: anElement [

	self addedToSpace ifTrue: [ ^ self ].
	addedToSpace := true.
	self whenAddedToSpace: anEvent in: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> sendWhenRemovedFromSpace: anEvent in: anElement [

	self addedToSpace ifFalse: [ ^ self ].
	addedToSpace := false.
	self whenRemovedFromSpace: anEvent in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: addedToSpaceHandler.
	anElement removeEventHandler: removedFromSpaceHandler
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> whenAddedToSpace: anEvent in: anElement [ 

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetSkin >> whenRemovedFromSpace: anEvent in: anElement [


]
