Class {
	#name : #Toplo,
	#superclass : #Object,
	#classVars : [
		'DefaultThemeClass'
	],
	#category : #'Toplo-Core'
}

{ #category : #initialization }
Toplo class >> closeAllSpaces [

	BlOSWindowSDL2Host universe closeSpaces.
	BlOSWindowSDL2Host
		stop;
		start.
	BlMorphicWindowHost universe closeSpaces.
	BlMorphicWindowHost
		stop;
		start
]

{ #category : #settings }
Toplo class >> defaultThemeClass [

	^ DefaultThemeClass ifNil: [ DefaultThemeClass := ToRawTheme ]
]

{ #category : #settings }
Toplo class >> defaultThemeClass: aClass [

	DefaultThemeClass := aClass
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
