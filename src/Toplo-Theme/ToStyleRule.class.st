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

{ #category : #testing }
ToStyleRule >> canBeAppliedTo: anElement [

	| engine |
	engine := ToStyleSelectorInterpreter new.
	engine check: self selector on: anElement.
	^ engine result
]

{ #category : #accessing }
ToStyleRule >> event: aLookEventClass [

	eventClass := aLookEventClass
]

{ #category : #accessing }
ToStyleRule >> eventClass [

	^ eventClass
]

{ #category : #initialization }
ToStyleRule >> initialize [

	super initialize.
	selector := ToUniversalSelector new.
	eventClass := ToInstallLookEvent.
	writers := #(  )
]

{ #category : #'property writer' }
ToStyleRule >> property: aProperty value: aValuableOrObject [

	self property: aProperty value: aValuableOrObject animation: nil
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
ToStyleRule >> selector [

	^ selector
]

{ #category : #accessing }
ToStyleRule >> selector: aStyleSelector [

	selector := aStyleSelector
]
