Class {
	#name : #ToDresser,
	#superclass : #ToCompanion,
	#instVars : [
		'next',
		'theme',
		'addedToParentHandler'
	],
	#classVars : [
		'UseLookAndFeel'
	],
	#category : #'Toplo-Core'
}

{ #category : #'instance creation' }
ToDresser class >> next: aDresser [

	^ self new next: aDresser
]

{ #category : #'api - install/uninstall  hook' }
ToDresser class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #useLookAndFeel)
		target: self;
		parent: #Bloc;
		default: false;
		description: 'Set to true to use the look and feel features (Experimental for now)';
		label: 'Use look&Feel features'
]

{ #category : #'api - install/uninstall  hook' }
ToDresser class >> useLookAndFeel [

	^ UseLookAndFeel ifNil: [ UseLookAndFeel := false ]
]

{ #category : #'api - install/uninstall  hook' }
ToDresser class >> useLookAndFeel: aBoolean [

	UseLookAndFeel := aBoolean
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

	self useLookAndFeel ifFalse: [ ^ self ].
	addedToParentHandler := BlEventHandler
		                        on: BlElementAddedToParentEvent
		                        do: [ self whenAdded: anElement ].
	anElement addEventHandler: addedToParentHandler
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

	^ theme
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: addedToParentHandler.
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> useLookAndFeel [

	^ self class useLookAndFeel
]

{ #category : #'api - install/uninstall  hook' }
ToDresser >> whenAdded: anElement [

	self flag:'labordep: Check Theme installation : this is a patch for first Space instanciation and need to be remove when a better pattern is found'.
	 anElement space ifNil:[ ^ self ].
    anElement space toTheme ifNil:[ ^ self ].
    (anElement space isThemeInstalled not and:[anElement space toTheme notNil]) ifTrue:[ anElement toTheme installOnSpace: anElement space ].
    anElement toThemeChanged
]
