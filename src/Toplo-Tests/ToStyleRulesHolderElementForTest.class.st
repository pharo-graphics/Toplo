Class {
	#name : 'ToStyleRulesHolderElementForTest',
	#superclass : 'Object',
	#classTraits : 'TToStyleRulesHolder classTrait',
	#instVars : [
		'styleRules'
	],
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - style rule holder - accessing' }
ToStyleRulesHolderElementForTest >> addAllStyleRules: aStyleRuleCollection [

	self rawStyleRules: (self rawStyleRules copyWithAll: aStyleRuleCollection)
]

{ #category : 't - style rule holder - accessing' }
ToStyleRulesHolderElementForTest >> addStyleRule: aStyleRule [

	self rawStyleRules: (self rawStyleRules copyWith: aStyleRule)
]

{ #category : 'initialization' }
ToStyleRulesHolderElementForTest >> initialize [ 

	super 	initialize.
	self rawStyleRules: #(  )
]

{ #category : 't - style rule holder - accessing' }
ToStyleRulesHolderElementForTest >> rawStyleRules [

	^ styleRules
]

{ #category : 't - style rule holder - accessing' }
ToStyleRulesHolderElementForTest >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]

{ #category : 't - style rule holder - accessing' }
ToStyleRulesHolderElementForTest >> styleRules [

	^ self rawStyleRules 
]

{ #category : 't - style rule holder - accessing' }
ToStyleRulesHolderElementForTest >> styleRules: aStyleRuleCollection [

	self rawStyleRules: aStyleRuleCollection
]
