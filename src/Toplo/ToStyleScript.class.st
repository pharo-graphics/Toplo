Class {
	#name : 'ToStyleScript',
	#superclass : 'Object',
	#classTraits : 'TToStyleRulesHolder classTrait',
	#instVars : [
		'ruleStack'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'syntactic sugar' }
ToStyleScript >> action: aValuable with: aValue [

	aValuable value: aValue
]

{ #category : 'adding' }
ToStyleScript >> addPropertyWriter: aPropertyWriter [

	self ruleStack top addPropertyWriter: aPropertyWriter
]

{ #category : 'syntactic sugar' }
ToStyleScript >> any [

 	^ ToUniversalSelector new

]

{ #category : 'syntactic sugar' }
ToStyleScript >> child: aSelector [

	^ ToChildSelector new
		  left: self any;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'syntactic sugar' }
ToStyleScript >> child: aSelector depth: anInteger [

	^ ToChildSelector new
		  depth: anInteger;
		  left: self any;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'accessing' }
ToStyleScript >> eventClass [

	^ self ruleStack top eventClass
]

{ #category : 'initialization' }
ToStyleScript >> initialize [ 

	super initialize.
	ruleStack := Stack new
]

{ #category : 'syntactic sugar' }
ToStyleScript >> parent: aSelector [

	^ ToParentSelector new
		  left: self any;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'syntactic sugar' }
ToStyleScript >> parent: aSelector depth: anInteger [

	^ ToParentSelector new
		depth: anInteger;
		  left: self any;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'accessing' }
ToStyleScript >> ruleStack [

	^ ruleStack
]

{ #category : 'syntactic sugar' }
ToStyleScript >> select: aStyleSelector style: aBlock [

	| rule |
	self ruleStack push: (ToStyleRule new selector: aStyleSelector asElementSelector).
	aBlock cull: self.
	rule := self ruleStack pop.
	self ruleStack ifNotEmpty: [:stk | stk top addStyleRule: rule ].
	^ rule

]

{ #category : 'syntactic sugar' }
ToStyleScript >> selector [

	^ self ruleStack top selector
]

{ #category : 'syntactic sugar' }
ToStyleScript >> supplement: aProperty with: aValuableOrObject [

	self
		when: self eventClass
		supplement: aProperty
		with: aValuableOrObject
]

{ #category : 'syntactic sugar' }
ToStyleScript >> when: aLookEventClass supplement: aWritableProperty with: aValuableOrObject [

	self addPropertyWriter: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWritableProperty;
			 value: aValuableOrObject;
			 supplement: true;
			 yourself)
]

{ #category : 'syntactic sugar' }
ToStyleScript >> when: aLookEventClass write: aProperty with: aValuableOrObject [

	self
		when: aLookEventClass
		write: aProperty
		with: aValuableOrObject
		animation: nil
]

{ #category : 'syntactic sugar' }
ToStyleScript >> when: aLookEventClass write: aWriteableProperty with: aValuableOrObject animation: aPropertyAnimation [

	self addPropertyWriter: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWriteableProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 supplement: false;
			 yourself)
]

{ #category : 'syntactic sugar' }
ToStyleScript >> write: aProperty with: aValue [

	self
		when: self eventClass
		write: aProperty
		with: aValue
		animation: nil
]
