Class {
	#name : #ToStyleDictionary,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : #'Toplo-StyleSheet-StaticModel'
}

{ #category : #initialization }
ToStyleDictionary >> initialize [ 

	super initialize.
	index := CTEnvironment new.
	self initializeDefaultThemeRules
]
