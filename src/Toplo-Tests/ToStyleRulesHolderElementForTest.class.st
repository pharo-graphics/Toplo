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

{ #category : #accessing }
ToStyleRulesHolderElementForTest >> rawStyleRules [

	^ styleRules
]

{ #category : #accessing }
ToStyleRulesHolderElementForTest >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]
