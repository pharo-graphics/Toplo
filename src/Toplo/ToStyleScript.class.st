Class {
	#name : #ToStyleScript,
	#superclass : #Object,
	#traits : 'TToStyleRulesHolder + TToStyleRuleScripter',
	#classTraits : 'TToStyleRulesHolder classTrait + TToStyleRuleScripter classTrait',
	#instVars : [
		'ruleStack',
		'styleRules'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'private - adding' }
ToStyleScript >> addSkinEventListener: aPropertyWriter [

	ruleStack top addSkinEventListener: aPropertyWriter
]

{ #category : #initialization }
ToStyleScript >> initialize [

	super initialize.
	ruleStack := Stack new.
	styleRules := #(  )
]

{ #category : #'rules declaring' }
ToStyleScript >> newUniversalSelector [

	^ ruleStack
		  ifEmpty: [ ToUniversalSelector new ]
		  ifNotEmpty: [ :stk | stk top selector ]
]

{ #category : #'rules declaring' }
ToStyleScript >> pushStyleRuleFor: aStyleSelector styleWith: aBlock [

	| rule |
	ruleStack push: (ToStyleRule new selector: aStyleSelector).
	aBlock cull: self.
	rule := ruleStack pop.
	ruleStack
		ifEmpty: [ self addStyleRule: rule ]
		ifNotEmpty: [ :stk | stk top addStyleRule: rule ]
]

{ #category : #accessing }
ToStyleScript >> rawStyleRules [

	^ styleRules
]

{ #category : #accessing }
ToStyleScript >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]

{ #category : #accessing }
ToStyleScript >> ruleStack [

	^ ruleStack
]

{ #category : #accessing }
ToStyleScript >> rules [

	^ self styleRules 
]

{ #category : #'t - stylesheet scripter' }
ToStyleScript >> skinEventListenerHolder [ 

	^ self 
]
