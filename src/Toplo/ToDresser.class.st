Class {
	#name : #ToDresser,
	#superclass : #ToCompanion,
	#instVars : [
		'next',
		'theme',
		'addedToParentHandler',
		'removedFromParentHandler',
		'addedToSpaceHandler',
		'removedFromSpaceHandler',
		'addedToSpace'
	],
	#category : #'Toplo-Core'
}

{ #category : #'instance creation' }
ToDresser class >> next: aDresser [

	^ self new next: aDresser
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> addDresser: aDresser in: anElement [

	self = aDresser ifTrue: [ ^ self ].
	self next addDresser: aDresser in: anElement previous: self
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> addDresser: aDresser in: anElement previous: aPreviousDresser [

	self = aDresser ifTrue: [ ^ self ].
	self next addDresser: aDresser in: anElement previous: self
]

{ #category : #accessing }
ToDresser >> addedToSpace [

	^ addedToSpace ifNil: [ addedToSpace := false ]
]

{ #category : #'t - accessing - dresser' }
ToDresser >> dresserSatisfying: aBlock [

	(aBlock value: self) ifTrue: [ ^ self ].
	^ next dresserSatisfying: aBlock
]

{ #category : #initialization }
ToDresser >> initialize [

	super initialize.
	next := ToNullDresser new.
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> installEventListenersIn: anElement [

	addedToParentHandler := BlEventHandler
		                        on: BlElementAddedToParentEvent
		                        do: [ self whenAddedToParent: anElement ].
	removedFromParentHandler := BlEventHandler
		                        on: BlElementRemovedFromParentEvent
		                        do: [ self whenRemovedFromParent: anElement ].
	
	anElement isAttachedToSceneGraph 
		ifTrue: [ self sendWhenAddedToSpace: nil in: anElement ]
		ifFalse: [ self sendWhenRemovedFromSpace: nil in: anElement ].
	
	addedToSpaceHandler := BlEventHandler
		                        on: BlElementAddedToSceneGraphEvent 
		                        do: [ :event | self sendWhenAddedToSpace: event in: anElement ].
	removedFromSpaceHandler := BlEventHandler
		                        on: BlElementRemovedFromSceneGraphEvent 
		                        do: [ :event | self sendWhenRemovedFromSpace: event in: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler.
	anElement addEventHandler: addedToSpaceHandler.
	anElement addEventHandler: removedFromSpaceHandler
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> next [

	^ next
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> next: aDresser [

	next := aDresser.
	
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	theme := 	anElement theme.
	next launchInstallationIn: anElement.
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	theme := 	nil.
	next launchUninstallationIn: anElement.
	self uninstallEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> removeDresser: aDresser in: anElement [

	next = aDresser ifFalse: [ next removeDresser: aDresser in: anElement. ^self ].
	next := aDresser next.
	aDresser next: ToNullDresser new.
	aDresser launchUninstallationIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> sendWhenAddedToSpace: anEvent in: anElement [

	self addedToSpace ifTrue: [ ^ self ].
	addedToSpace := true.
	self whenAddedToSpace: anEvent in: anElement


]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> sendWhenRemovedFromSpace: anEvent in: anElement [

	self addedToSpace ifFalse: [ ^ self ].
	addedToSpace := false.
	self whenRemovedFromSpace: anEvent in: anElement

]

{ #category : #accessing }
ToDresser >> theme [

	^ theme
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: addedToParentHandler.
	anElement removeEventHandler: removedFromParentHandler.
	anElement removeEventHandler: addedToSpaceHandler.
	anElement removeEventHandler: removedFromSpaceHandler
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> useLookAndFeel [

	^ Toplo useLookAndFeel
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> whenAddedToParent: anElement [

	Toplo useLookAndFeel ifFalse: [ ^ self ].
	self flag:
		'labordep: Check Theme installation : this is a patch for first Space instanciation and need to be remove when a better pattern is found'.
	anElement checkSkinInstallation.
	anElement space ifNil: [ ^ self ].
	anElement space toTheme ifNil: [ ^ self ].
	(anElement space isThemeInstalled not and: [
		 anElement space toTheme notNil ]) ifTrue: [
		anElement toTheme installOnSpace: anElement space ].
	anElement toThemeChanged
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> whenAddedToSpace: anEvent in: anElement [ 

	self flag: 'Leads to ToSpaceFrameSkinInstallationPhase installation in space frame. Should be revised to avoid this kind of workaround'.
	anElement space checkSpaceFrameSkinInstallationPhase.
	anElement checkSkinInstallation 
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> whenRemovedFromParent: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> whenRemovedFromSpace: anEvent in: anElement [

]
