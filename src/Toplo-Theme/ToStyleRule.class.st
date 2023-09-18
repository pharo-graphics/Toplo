Class {
	#name : #ToStyleRule,
	#superclass : #Object,
	#traits : 'TToPropertyWriterHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait',
	#instVars : [
		'selector',
		'eventClass',
		'writers'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #'instance creation' }
ToStyleRule class >> selectedWith: aStyleSelector style: aBlock [

	^ self new selectedWith: aStyleSelector style: aBlock
]

{ #category : #'instance creation' }
ToStyleRule class >> selectedWith: aStyleSelector when: anLookEventClass  style: aBlock [

	^ self new
		  selectedWith: aStyleSelector
		  when: anLookEventClass
		  style: aBlock
]

{ #category : #testing }
ToStyleRule >> canBeAppliedTo: anElement [

	| engine |
	engine := ToStyleSelectorInterpreter new.
	engine check: self selector on: anElement.
	^ engine result
]

{ #category : #accessing }
ToStyleRule >> event: aLookEventClass [

	self eventClass: aLookEventClass
]

{ #category : #'property writer' }
ToStyleRule >> event: aLookEventClass property: aProperty value: aValuableOrObject [

	self event: aLookEventClass property: aProperty value: aValuableOrObject animation: nil
]

{ #category : #'property writer' }
ToStyleRule >> event: aLookEventClass property: aProperty value: aValuableOrObject animation: aPropertyAnimation [

	self addWriter: (ToPropertyWriter new
			 property: aProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 eventClass: aLookEventClass;
			 yourself)
]

{ #category : #accessing }
ToStyleRule >> eventClass [

	^ eventClass
]

{ #category : #accessing }
ToStyleRule >> eventClass: aLookEventClass [

	eventClass := aLookEventClass
]

{ #category : #initialization }
ToStyleRule >> initialize [

	super initialize.
	selector := ToUniversalSelector new.
	eventClass := ToInstallLookEvent.
	writers := #(  )
]

{ #category : #'property writer' }
ToStyleRule >> property: aProperty value: aValuableOrObject animation: aPropertyAnimation [

	self addWriter: (ToPropertyWriter new
			 property: aProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 eventClass: self eventClass;
			 yourself)
]

{ #category : #'t - property writer holder - accessing' }
ToStyleRule >> rawWriters [

	^ writers
]

{ #category : #'t - property writer holder - accessing' }
ToStyleRule >> rawWriters: aPropertyWriterCollection [

	writers := aPropertyWriterCollection 
]

{ #category : #accessing }
ToStyleRule >> selectedWith: aStyleSelector style: aBlock [

	self selector: aStyleSelector.
	aBlock value: self
	
]

{ #category : #accessing }
ToStyleRule >> selectedWith: aStyleSelector when: anEventClass style: aBlock [

	self eventClass: anEventClass.
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

	self addWriter: (ToPropertyWriter new
			 property: aProperty;
			 value: aValuableOrObject;
			 animation: nil;
			 eventClass: self eventClass;
			 supplement: true;
			 yourself)
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass supplement: aProperty with: aValuableOrObject [

		self addWriter: (ToPropertyWriter new
			 property: aProperty;
			 value: aValuableOrObject;
			 animation: nil;
			 eventClass: aLookEventClass;
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

	self addWriter: (ToPropertyWriter new
			 property: aProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 eventClass: aLookEventClass;
			 yourself)
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
