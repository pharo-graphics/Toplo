Class {
	#name : #Toplo,
	#superclass : #Object,
	#classVars : [
		'DefaultThemeClass',
		'LastInstalledTheme',
		'ToploAnnouncer'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
Toplo class >> announcer [

	^ ToploAnnouncer ifNil: [ ToploAnnouncer := Announcer  new ]
]

{ #category : #initialization }
Toplo class >> closeAllSpaces [

	self
		deprecated: 'Use #closeSpaces instead'
		transformWith: '`@receiver closeAllSpaces' -> '`@receiver closeSpaces'.

	self closeSpaces
]

{ #category : #initialization }
Toplo class >> closeSpaces [

	Bloc closeSpaces
]

{ #category : #settings }
Toplo class >> defaultThemeClass [

	^ DefaultThemeClass ifNil: [ DefaultThemeClass := ToRawTheme ]
]

{ #category : #settings }
Toplo class >> defaultThemeClass: aClass [

	DefaultThemeClass = aClass ifTrue: [ ^ self ].
	DefaultThemeClass := aClass.
	self announcer announce: ToThemeSettingChangedEvent
]

{ #category : #accessing }
Toplo class >> lastInstalledTheme [
	" can serve as a fallback skin in case of error. 
	For example, to try to not break the UI when fetching a stamp or a token value "
	^ LastInstalledTheme 
]

{ #category : #accessing }
Toplo class >> lastInstalledTheme: aTheme [

	LastInstalledTheme := aTheme
]

{ #category : #settings }
Toplo class >> newDefaultThemeInstance [

	^ self defaultThemeClass new
]

{ #category : #initialization }
Toplo class >> resetCanvasScaleFactor [

	<script>
	OSWorldRenderer
		autoSetCanvasScaleFactor: false;
		canvasScaleFactor: 1
]

{ #category : #settings }
Toplo class >> settingsOn: aBuilder [

	<systemsettings>
	(aBuilder group: #Toplo)
		label: 'Toplo';
		description: 'Toplo settings';
		parent: #appearance;
		with: [
			(aBuilder pickOne: #defaultThemeClass)
				target: self;
				order: 1;
				label: 'Default theme';
				domainValues: self supportedThemeClasses;
				description: 'Choose the default theme for Toplo' ]
]

{ #category : #settings }
Toplo class >> supportedThemeClasses [

	^ (ToTheme allSubclasses 
			select: [ :aThemeClass | aThemeClass canBeDefault ])
			sort: [ :a :b | a name < b name ]
]
