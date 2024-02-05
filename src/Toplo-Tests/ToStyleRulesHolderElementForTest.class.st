Class {
	#name : #ToStyleRulesHolderElementForTest,
	#superclass : #Object,
	#traits : 'TToStyleRulesHolder',
	#classTraits : 'TToStyleRulesHolder classTrait',
	#instVars : [
		'styleRules'
	],
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #initialization }
ToStyleRulesHolderElementForTest >> initialize [ 

	super 	initialize.
	self rawStyleRules: #(  )
]

{ #category : #'t - style rule holder - accessing' }
ToStyleRulesHolderElementForTest >> rawStyleRules [

	^ styleRules
]

{ #category : #'t - style rule holder - accessing' }
ToStyleRulesHolderElementForTest >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]
