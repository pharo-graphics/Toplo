Class {
	#name : #ToStyleRule,
	#superclass : #Object,
	#traits : 'TToPropertyWriterHolder + TToStyleRuleHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait + TToStyleRuleHolder classTrait',
	#instVars : [
		'selector',
		'writers',
		'styleRules'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #declaring }
ToStyleRule >> addSubStyleRule: aStyleRule [

	self addStyleRule: aStyleRule
]

{ #category : #testing }
ToStyleRule >> canBeAppliedTo: anElement [

	| engine |
	engine := ToStyleSelectorInterpreter new.
	engine check: self selector on: anElement.
	^ engine result
]

{ #category : #accessing }
ToStyleRule >> eventClass [

	^ ToInstallLookEvent 
]

{ #category : #initialization }
ToStyleRule >> initialize [

	super initialize.
	selector := ToUniversalSelector new.
	writers := #(  ).
	styleRules := #(  )
]

{ #category : #'property writer' }
ToStyleRule >> property: aProperty value: aValuableOrObject animation: aPropertyAnimation [

	self addWriter: (aProperty
			 when: self eventClass
			 write: aValuableOrObject
			 animation: aPropertyAnimation;
			 yourself)
]

{ #category : #'writers selecting' }
ToStyleRule >> putAllWritersFor: anElement in: aStream [

	(self canBeAppliedTo: anElement) ifFalse: [ ^ self ].
	aStream nextPutAll: self writers.
	self styleRules do: [ :r | r putAllWritersFor: anElement in: aStream ] 
]

{ #category : #'t - style rule holder - accessing' }
ToStyleRule >> rawStyleRules [

	^ styleRules
]

{ #category : #'t - style rule holder - accessing' }
ToStyleRule >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]

{ #category : #'t - property writer holder - accessing' }
ToStyleRule >> rawWriters [

	^ writers
]

{ #category : #'t - property writer holder - accessing' }
ToStyleRule >> rawWriters: aPropertyWriterCollection [

	writers := aPropertyWriterCollection 
]

{ #category : #declaring }
ToStyleRule >> selectedWith: aStyleSelector style: aBlock [

	self selector: aStyleSelector.
	aBlock value: self
	
]

{ #category : #accessing }
ToStyleRule >> selector [

	^ selector
]

{ #category : #accessing }
ToStyleRule >> selector: aStyleSelector [

	selector := aStyleSelector
]

{ #category : #'syntactic sugar' }
ToStyleRule >> supplement: aProperty with: aValuableOrObject [

	self
		when: self eventClass
		supplement: aProperty
		with: aValuableOrObject
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass supplement: aProperty with: aValuableOrObject [

	aProperty ifNil: [ ^self ].
	self addWriter: ((aProperty
			  when: aLookEventClass
			  write: aValuableOrObject
			  animation: nil)
			 supplement: true;
			 yourself)
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass write: aProperty with: aValuableOrObject [

	self
		when: aLookEventClass
		write: aProperty
		with: aValuableOrObject
		animation: nil
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass write: aProperty with: aValuableOrObject animation: aPropertyAnimation [

	aProperty ifNil: [ ^ self ].
	self addWriter: (aProperty
			 when: aLookEventClass
			 write: aValuableOrObject
			 animation: aPropertyAnimation)
]

{ #category : #'syntactic sugar' }
ToStyleRule >> write: aProperty with: aValue [

	self
		when: self eventClass
		write: aProperty
		with: aValue
		animation: nil
]

{ #category : #'syntactic sugar' }
ToStyleRule >> write: aProperty with: aValuableOrObject animation: aPropertyAnimation [

	self
		when: self eventClass
		write: aProperty
		with: aValuableOrObject
		animation: aPropertyAnimation
]
