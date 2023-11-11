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
	#category : 'Toplo-Core-StyleSheet'
}

{ #category : #declaring }
ToStyleRule >> addSubStyleRule: aStyleRule [

	self addStyleRule: aStyleRule
]

{ #category : #testing }
ToStyleRule >> canBeAppliedTo: anElement [

	| engine |
	engine := ToSelectorInterpreter new.
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
ToStyleRule >> supplement: aWriteableProperty with: aValuableOrObject [

	self
		when: self eventClass
		supplement: aWriteableProperty
		with: aValuableOrObject
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass supplement: aWriteableProperty with: aValuableOrObject [

	aWriteableProperty ifNil: [ ^ self ].
	self addWriter: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWriteableProperty;
			 value: aValuableOrObject;
			 supplement: true;
			 yourself)
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass write: aWriteableProperty with: aValuableOrObject [

	self
		when: aLookEventClass
		write: aWriteableProperty
		with: aValuableOrObject
		animation: nil
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass write: aWriteableProperty with: aValuableOrObject animation: aPropertyAnimation [

	aWriteableProperty ifNil: [ ^ self ].
	self addWriter: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWriteableProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 supplement: false;
			 yourself)
]

{ #category : #'syntactic sugar' }
ToStyleRule >> write: aWriteableProperty with: aValue [

	self
		when: self eventClass
		write: aWriteableProperty
		with: aValue
		animation: nil
]

{ #category : #'syntactic sugar' }
ToStyleRule >> write: aWriteableProperty with: aValuableOrObject animation: aPropertyAnimation [

	self
		when: self eventClass
		write: aWriteableProperty
		with: aValuableOrObject
		animation: aPropertyAnimation
]
