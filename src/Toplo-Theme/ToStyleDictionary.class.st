Class {
	#name : #ToStyleDictionary,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Theme-StyleSheet-Metamodel'
}

{ #category : #initialization }
ToStyleDictionary >> initialize [ 

	super initialize.
	index := CTEnvironment new.
	self initializeDefaultThemeRules
]
