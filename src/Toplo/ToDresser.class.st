Class {
	#name : #ToDresser,
	#superclass : #ToCompanion,
	#instVars : [
		'next',
		'theme',
		'addedToParentHandler'
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

{ #category : #private }
ToDresser >> blElementAddedToParentEvent: anElement [

	anElement space ifNil:[ ^ self ].
	anElement toThemeChanged
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

	"Notify when the element is added on a new parent to check if the parent change need to changed anything (for exemple a theme change)"
	addedToParentHandler := BlEventHandler 
		on: BlElementAddedToParentEvent 
		do: [ :event | self blElementAddedToParentEvent: anElement ].
	anElement addEventHandler: addedToParentHandler.
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

{ #category : #accessing }
ToDresser >> theme [

	^ theme ifNil:[ ^ OBlTheme default ]
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: addedToParentHandler.
	addedToParentHandler := nil.
]
