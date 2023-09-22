Class {
	#name : #ToStyleScript,
	#superclass : #Object,
	#classTraits : 'TToStyleRuleHolder classTrait',
	#instVars : [
		'ruleStack'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #adding }
ToStyleScript >> addWriter: aPropertyWriter [

	self ruleStack top addWriter: aPropertyWriter
]

{ #category : #accessing }
ToStyleScript >> eventClass [

	^ self ruleStack top eventClass
]

{ #category : #initialization }
ToStyleScript >> initialize [ 

	super initialize.
	ruleStack := Stack new
]

{ #category : #accessing }
ToStyleScript >> ruleStack [

	^ ruleStack
]

{ #category : #'syntactic sugar' }
ToStyleScript >> select: aStyleSelector style: aBlock [

	| rule |
	self ruleStack push: (ToStyleRule new selector: aStyleSelector asStyleSelector).
	aBlock cull: self.
	rule := self ruleStack pop.
	self ruleStack isEmpty
		ifTrue: [ ^ rule ].
	self ruleStack top addSubStyleRule: rule

]

{ #category : #'syntactic sugar' }
ToStyleScript >> supplement: aProperty with: aValuableOrObject [

	self
		when: self eventClass
		supplement: aProperty
		with: aValuableOrObject
]

{ #category : #'syntactic sugar' }
ToStyleScript >> when: aLookEventClass supplement: aProperty with: aValuableOrObject [

	aProperty ifNil: [ ^self ].
	self addWriter: ((aProperty
			  when: aLookEventClass
			  write: aValuableOrObject
			  animation: nil)
			 supplement: true;
			 yourself)
]

{ #category : #'syntactic sugar' }
ToStyleScript >> when: aLookEventClass write: aProperty with: aValuableOrObject [

	self
		when: aLookEventClass
		write: aProperty
		with: aValuableOrObject
		animation: nil
]

{ #category : #'syntactic sugar' }
ToStyleScript >> when: aLookEventClass write: aProperty with: aValuableOrObject animation: aPropertyAnimation [

	aProperty ifNil: [ ^ self ].
	self addWriter: (aProperty
			 when: aLookEventClass
			 write: aValuableOrObject
			 animation: aPropertyAnimation)
]

{ #category : #'syntactic sugar' }
ToStyleScript >> write: aProperty with: aValue [

	self
		when: self eventClass
		write: aProperty
		with: aValue
		animation: nil
]

{ #category : #writing }
ToStyleScript >> write: aProperty with: aValuableOrObject animation: aPropertyAnimation [

	self
		when: self eventClass
		write: aProperty
		with: aValuableOrObject
		animation: aPropertyAnimation
]
