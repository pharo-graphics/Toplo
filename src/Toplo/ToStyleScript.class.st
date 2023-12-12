Class {
	#name : 'ToStyleScript',
	#superclass : 'Object',
	#traits : 'TToStyleRulesHolder + TToStyleRuleScripter',
	#classTraits : 'TToStyleRulesHolder classTrait + TToStyleRuleScripter classTrait',
	#instVars : [
		'ruleStack',
		'styleRules'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'private - adding' }
ToStyleScript >> addLookEventListener: aPropertyWriter [

	self ruleStack top addLookEventListener: aPropertyWriter
]

{ #category : 'initialization' }
ToStyleScript >> initialize [

	super initialize.
	ruleStack := Stack new.
	styleRules := #(  )
]

{ #category : 't - stylesheet scripter' }
ToStyleScript >> lookEventListenerHolder [ 

	^ self 
]

{ #category : 'rules declaring' }
ToStyleScript >> newUniversalSelector [

	^ self ruleStack
		  ifEmpty: [ ToUniversalSelector new ]
		  ifNotEmpty: [ :stk | stk top selector ]
]

{ #category : 'rules declaring' }
ToStyleScript >> pushStyleRuleFor: aStyleSelector styleWith: aBlock [

	| rule |
	self ruleStack push: (ToStyleRule new selector: aStyleSelector).
	aBlock cull: self.
	rule := self ruleStack pop.
	self ruleStack
		ifEmpty: [ self addStyleRule: rule ]
		ifNotEmpty: [ :stk | stk top addStyleRule: rule ]
]

{ #category : 't - style rules holder' }
ToStyleScript >> rawStyleRules [

	^ styleRules
]

{ #category : 't - style rules holder' }
ToStyleScript >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]

{ #category : 'accessing' }
ToStyleScript >> ruleStack [

	^ ruleStack
]

{ #category : 'accessing' }
ToStyleScript >> rules [

	^ self styleRules 
]
