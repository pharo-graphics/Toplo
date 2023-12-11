Class {
	#name : 'ToStyleScript',
	#superclass : 'Object',
	#traits : 'TToStyleRulesHolder + TToStyleSheetScripter',
	#classTraits : 'TToStyleRulesHolder classTrait + TToStyleSheetScripter classTrait',
	#instVars : [
		'ruleStack',
		'styleRules'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'private - adding' }
ToStyleScript >> addPropertyWriter: aPropertyWriter [

	self ruleStack top addPropertyWriter: aPropertyWriter
]

{ #category : 'initialization' }
ToStyleScript >> initialize [

	super initialize.
	ruleStack := Stack new.
	styleRules := #(  )
]

{ #category : 'rules declaring' }
ToStyleScript >> newUniversalSelector [

	^ self ruleStack
		  ifEmpty: [ ToUniversalSelector new ]
		  ifNotEmpty: [ :stk | stk top selector ]
]

{ #category : 't - stylesheet scripter' }
ToStyleScript >> propertyWritersHolder [ 

	^ self 
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
