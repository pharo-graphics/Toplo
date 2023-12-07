Class {
	#name : 'ToStyleScript',
	#superclass : 'Object',
	#traits : 'TToStyleRulesHolder',
	#classTraits : 'TToStyleRulesHolder classTrait',
	#instVars : [
		'ruleStack',
		'styleRules'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'style declaration' }
ToStyleScript class >> style: aBlock [ 
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> action: aValuable [ 

	 ^ ToActionSelector new action: aValuable 
]

{ #category : 'private - adding' }
ToStyleScript >> addPropertyWriter: aPropertyWriter [

	self ruleStack top addPropertyWriter: aPropertyWriter
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> any [

	^ self ruleStack
		  ifEmpty: [ ToUniversalSelector new ]
		  ifNotEmpty: [ :stk | stk top selector ]
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> child: aSelector [ 

	self
		deprecated: 'Please use #withChild: instead.'
		transformWith:
			'`@receiver child: `@arg1'
				-> '`@receiver withChild: `@arg1'.	
	^ self withChild: aSelector
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> child: aSelector depth: anInteger [

	self
		deprecated: 'Please use #withChild:atDepth: instead.'
		transformWith:
			'`@receiver child: `@arg1 depth: `@arg2'
				-> '`@receiver withChild: `@arg1 atDepth: `@arg2 '.	
	^ self withChild: aSelector atDepth: anInteger
]

{ #category : 'initialization' }
ToStyleScript >> initialize [

	super initialize.
	ruleStack := Stack new.
	styleRules := #(  )
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> parent: aSelector [ 

	self
		deprecated: 'Please use #withParent: instead.'
		transformWith:
			'`@receiver parent: `@arg1'
				-> '`@receiver withParent: `@arg1'.	
	^ self withParent: aSelector
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> parent: aSelector depth: anInteger [

	self
		deprecated: 'Please use #withParent:atDepth: instead.'
		transformWith:
			'`@receiver parent: `@arg1 depth: `@arg2'
				-> '`@receiver withParent: `@arg1 atDepth: `@arg2 '.	
	^ self withParent: aSelector atDepth: anInteger
]

{ #category : 't - style rules holder' }
ToStyleScript >> rawStyleRules [

	^ styleRules
]

{ #category : 't - style rules holder' }
ToStyleScript >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]

{ #category : 'sub rule adding' }
ToStyleScript >> ruleFromSelector: aStyleSelector style: aBlock [

	| rule |		
	self ruleStack push: (ToStyleRule new selector: aStyleSelector asElementSelector).
	aBlock cull: self.
	rule := self ruleStack pop.
	self ruleStack 
		ifEmpty: [ ^ rule ]
		ifNotEmpty: [:stk | stk top addStyleRule: rule ]
]

{ #category : 'accessing' }
ToStyleScript >> ruleStack [

	^ ruleStack
]

{ #category : 'sub rule adding' }
ToStyleScript >> select: aStyleSelector style: aBlock [

	| rule |
	self ruleStack push:
		(ToStyleRule new selector: aStyleSelector asElementSelector).
	aBlock cull: self.
	rule := self ruleStack pop.
	self ruleStack
		ifEmpty: [ self addStyleRule: rule ]
		ifNotEmpty: [ :stk | stk top addStyleRule: rule ]
]

{ #category : 'writer adding' }
ToStyleScript >> supplement: aProperty with: aValuableOrObject [

	self
		when: nil
		supplement: aProperty
		with: aValuableOrObject
]

{ #category : 'writer adding' }
ToStyleScript >> when: aLookEventClass supplement: aWritableProperty with: aValuableOrObject [

	self addPropertyWriter: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWritableProperty;
			 value: aValuableOrObject;
			 supplement: true;
			 yourself)
]

{ #category : 'writer adding' }
ToStyleScript >> when: aLookEventClass write: aProperty with: aValuableOrObject [

	self
		when: aLookEventClass
		write: aProperty
		with: aValuableOrObject
		animation: nil
]

{ #category : 'writer adding' }
ToStyleScript >> when: aLookEventClass write: aWriteableProperty with: aValuableOrObject animation: aPropertyAnimation [

	self addPropertyWriter: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWriteableProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 supplement: false;
			 yourself)
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> withChild: aSelector [

	^ ToChildSelector new
		  left: self any;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> withChild: aSelector atDepth: anInteger [

	^ ToChildSelector new
		  depth: anInteger;
		  left: self any;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> withParent: aSelector [

	^ ToParentSelector new
		  left: self any;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'selector syntactic sugar' }
ToStyleScript >> withParent: aSelector atDepth: anInteger [

	^ ToParentSelector new
		depth: anInteger;
		  left: self any;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'writer adding' }
ToStyleScript >> write: aProperty with: aValue [

	self
		when: nil
		write: aProperty
		with: aValue
		animation: nil
]
