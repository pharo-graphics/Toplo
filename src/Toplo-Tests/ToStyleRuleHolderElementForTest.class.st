Class {
	#name : 'ToStyleRuleHolderElementForTest',
	#superclass : 'Object',
	#classTraits : 'TToStyleRuleHolder classTrait',
	#instVars : [
		'rules'
	],
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - style rule holder - accessing' }
ToStyleRuleHolderElementForTest >> addAllStyleRules: aStyleRuleCollection [

	self rawStyleRules: (self rawStyleRules copyWithAll: aStyleRuleCollection)
]

{ #category : 't - style rule holder - accessing' }
ToStyleRuleHolderElementForTest >> addStyleRule: aStyleRule [

	self rawStyleRules: (self rawStyleRules copyWith: aStyleRule)
]

{ #category : 'initialization' }
ToStyleRuleHolderElementForTest >> initialize [ 

	super 	initialize.
	rules := #(  )
]

{ #category : 't - style rule holder - accessing' }
ToStyleRuleHolderElementForTest >> rawStyleRules [

	^ rules
]

{ #category : 't - style rule holder - accessing' }
ToStyleRuleHolderElementForTest >> rawStyleRules: aStyleRuleCollection [

	rules := aStyleRuleCollection
]

{ #category : 't - style rule holder - accessing' }
ToStyleRuleHolderElementForTest >> styleRules [

	^ self rawStyleRules 
]

{ #category : 't - style rule holder - accessing' }
ToStyleRuleHolderElementForTest >> styleRules: aStyleRuleCollection [

	self rawStyleRules: aStyleRuleCollection
]
