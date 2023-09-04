Class {
	#name : #ToStyleDictionary,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : #'Toplo-StyleSheet-Model'
}

{ #category : #initialization }
ToStyleDictionary >> initialize [ 

	super initialize.
	index := CTEnvironment new.
	self initializeComputedValues
]
