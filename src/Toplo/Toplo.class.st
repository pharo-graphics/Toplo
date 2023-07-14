Class {
	#name : #Toplo,
	#superclass : #Object,
	#classVars : [
		'UseLookAndFeel'
	],
	#category : #'Toplo-Core'
}

{ #category : #settings }
Toplo class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #Toplo) 
		label: 'Toplo';
		description: 'Toplo settings';
		parent: #appearance.
		
	(aBuilder setting: #useLookAndFeel)
		target: self;
		parent: #Toplo;
		default: false;
		description: 'Set to true to use the look and feel features (Experimental for now)';
		label: 'Look & Feel features (experimental)'
]

{ #category : #settings }
Toplo class >> useLookAndFeel [

	^ UseLookAndFeel ifNil: [ UseLookAndFeel := false ]
]

{ #category : #settings }
Toplo class >> useLookAndFeel: aBoolean [

	UseLookAndFeel := aBoolean
]
