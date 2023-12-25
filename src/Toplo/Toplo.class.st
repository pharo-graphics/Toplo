Class {
	#name : #Toplo,
	#superclass : #Object,
	#classVars : [
		'DefaultThemeClass',
		'DefaultThemeVariantClass'
	],
	#category : 'Toplo-Core'
}

{ #category : #settings }
Toplo class >> defaultThemeClass [

	^ DefaultThemeClass ifNil: [ DefaultThemeClass := ToRawTheme ]
]

{ #category : #settings }
Toplo class >> defaultThemeClass: aClass [

	DefaultThemeClass := aClass.
	(DefaultThemeClass supportedVariantClasses includes: self defaultThemeVariantClass) ifFalse: [
		self defaultThemeVariantClass: DefaultThemeClass supportedVariantClasses first ]
]

{ #category : #settings }
Toplo class >> defaultThemeVariantClass [

	^ DefaultThemeVariantClass ifNil: [ DefaultThemeVariantClass := ToThemeLightVariant ]
]

{ #category : #settings }
Toplo class >> defaultThemeVariantClass: aThemeVariantClass [

	DefaultThemeVariantClass := aThemeVariantClass
]

{ #category : #settings }
Toplo class >> newDefaultThemeInstance [

	^ self defaultThemeClass variant: self defaultThemeVariantClass new
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
				description: 'Choose the default theme for Toplo'.
			(aBuilder pickOne: #defaultThemeVariantClass)
				target: self;
				order: 1;
				label: 'Default theme variant';
				domainValues: self defaultThemeClass supportedVariantClasses;
				description: 'Choose the default theme variant' ]
]

{ #category : #settings }
Toplo class >> supportedThemeClasses [

	^ (ToTheme allSubclasses 
			select: [ :aThemeClass | aThemeClass canBeDefault ])
			sort: [ :a :b | a name < b name ]
]
