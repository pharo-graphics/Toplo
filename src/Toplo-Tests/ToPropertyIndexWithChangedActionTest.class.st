Class {
	#name : #ToPropertyIndexWithChangedActionTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Properties'
}

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testAddAllProperties [

	| idx count |
	count := 0.
	idx := ToPropertyIndexWithChangedAction new changedAction: [ count := count + 1 ].
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: idx size equals: 2.
	self assert: count equals: 1.
	
	" no duplication allowed "
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: idx size equals: 2.
	self assert: count equals: 1

		
]

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testAddProperty [

	| idx count |
	count := 0.
	idx := ToPropertyIndexWithChangedAction new changedAction: [ count := count + 1 ].
	idx addProperty: (ToTokenProperty new name: #color).
	self assert: count equals: 1.
	self assert: idx size equals: 1.
	idx addProperty: (ToTokenProperty new name: #color; value: Color blue).
	self assert: count equals: 2.
	self assert: idx size equals: 1.
	idx addProperty: (ToTokenProperty new name: #color; value: Color blue).
	self assert: count equals: 2.
	self assert: idx size equals: 1.


		
]

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testAddPropertyWithBlockClosure [

	| idx count |
	count := 0.
	idx := ToPropertyIndexWithChangedAction new changedAction: [ count := count + 1 ].
	idx addProperty: (ToTokenProperty new name: #color; value: [:e | e defaultColor ] ).
	self assert: count equals: 1.
	self assert: idx size equals: 1.
	idx addProperty: (ToTokenProperty new name: #color; value: [:e | e defaultColor ]).
	self assert: count equals: 1.
	self assert: idx size equals: 1.
	idx addProperty: (ToTokenProperty new name: #color; value: Color blue).
	self assert: count equals: 2.
	self assert: idx size equals: 1.


		
]

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testChangedAction [

	| idx action |
	idx := ToPropertyIndexWithChangedAction new.
	self assert: idx changedAction notNil.
	self assert: idx changedAction isClosure.
	action := [ ].
	idx changedAction: action.
	self assert: idx changedAction identicalTo: action.


		
]

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testHasProperty [

	| idx  |
	idx := ToPropertyIndexWithChangedAction new .
	idx addProperty: (ToTokenProperty new name: #color1; value: Color blue ).
	idx addProperty: (ToTokenProperty new name: #color2; value: [:e | e defaultColor ] ).
	self assert: (idx hasProperty: (ToTokenProperty  new name: #color1; value: Color blue)).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color1; value: Color red)).
	self assert: (idx hasProperty: (ToTokenProperty  new name: #color2; value: [:e | e defaultColor ])).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color2; value: [:e | e color ])).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color; value: [:e | e color ]))



		
]

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testInitialize [

	| idx  |
	idx := ToPropertyIndexWithChangedAction new.
	self assert: idx changedAction notNil.
	self assert: idx changedAction isClosure.
		
]

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testRemoveAllProperties [

	| idx count |
	count := 0.
	idx := ToPropertyIndexWithChangedAction new changedAction: [ count := count + 1 ].
	idx removeAllProperties.
	self assert: count equals: 0.
	idx addAllProperties: {
			(ToTokenProperty new name: #color).
			(ToTokenProperty new name: #background) }.
	self assert: idx size equals: 2.
	self assert: count equals: 1.

	idx removeAllProperties.
	self assert: count equals: 2.
	self assert: idx size equals: 0
]

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testRemoveAllPropertiesFromNames [

	| idx count |
	count := 0.
	idx := ToPropertyIndexWithChangedAction new changedAction: [
		       count := count + 1 ].
	idx addAllProperties: {
			(ToTokenProperty new name: #color).
			(ToTokenProperty new name: #background) }.
	self assert: count equals: 1.
	idx removeAllPropertiesFromNames: #( #color #background ).
	self assert: count equals: 2.
	self assert: idx isEmpty.
	idx removeAllPropertiesFromNames: #( #color #background ).
	self assert: count equals: 2.
	self assert: idx isEmpty
]

{ #category : #tests }
ToPropertyIndexWithChangedActionTest >> testRemovePropertyNamed [

	| idx count |
	count := 0.
	idx := ToPropertyIndexWithChangedAction new changedAction: [ count := count + 1 ].
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: count equals: 1.
	idx removePropertyNamed: #color.
	self assert: count equals: 2.
	idx removePropertyNamed: #color.
	self assert: count equals: 2.
	self deny: (idx hasPropertyNamed: #color)

		
]
