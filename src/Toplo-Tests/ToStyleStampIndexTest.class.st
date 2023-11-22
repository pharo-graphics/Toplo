Class {
	#name : 'ToStyleStampIndexTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Properties',
	#package : 'Toplo-Tests',
	#tag : 'Core-Properties'
}

{ #category : 'tests' }
ToStyleStampIndexTest >> testAddAllProperties [

	| idx count |
	count := 0.
	idx := ToStyleStampIndex new changedAction: [ count := count + 1 ].
	idx addAllProperties: { (ToReadOnlyStyleStamp new name: #color). (ToReadOnlyStyleStamp new name: #background) } .
	self assert: idx size equals: 2.
	self assert: count equals: 1.
	
	" no duplication allowed "
	idx addAllProperties: { (ToReadOnlyStyleStamp new name: #color). (ToReadOnlyStyleStamp new name: #background) } .
	self assert: idx size equals: 2.
	self assert: count equals: 1

		
]

{ #category : 'tests' }
ToStyleStampIndexTest >> testAddProperty [

	| idx count |
	count := 0.
	idx := ToStyleStampIndex new changedAction: [ count := count + 1 ].
	idx addProperty: (ToReadOnlyStyleStamp new name: #color).
	self assert: count equals: 1.
	self assert: idx size equals: 1.
	idx addProperty: (ToReadOnlyStyleStamp new name: #color; value: Color blue).
	self assert: count equals: 2.
	self assert: idx size equals: 1.
	idx addProperty: (ToReadOnlyStyleStamp new name: #color; value: Color blue).
	self assert: count equals: 2.
	self assert: idx size equals: 1.


		
]

{ #category : 'tests' }
ToStyleStampIndexTest >> testAddPropertyWithBlockClosure [

	| idx count |
	count := 0.
	idx := ToStyleStampIndex new changedAction: [ count := count + 1 ].
	idx addProperty: (ToReadOnlyStyleStamp new name: #color; value: [:e | e defaultColor ] ).
	self assert: count equals: 1.
	self assert: idx size equals: 1.
	idx addProperty: (ToReadOnlyStyleStamp new name: #color; value: [:e | e defaultColor ]).
	self assert: count equals: 1.
	self assert: idx size equals: 1.
	idx addProperty: (ToReadOnlyStyleStamp new name: #color; value: Color blue).
	self assert: count equals: 2.
	self assert: idx size equals: 1.


		
]

{ #category : 'tests' }
ToStyleStampIndexTest >> testChangedAction [

	| idx action |
	idx := ToStyleStampIndex new.
	self assert: idx changedAction notNil.
	self assert: idx changedAction isClosure.
	action := [ ].
	idx changedAction: action.
	self assert: idx changedAction identicalTo: action.


		
]

{ #category : 'tests' }
ToStyleStampIndexTest >> testHasProperty [

	| idx  |
	idx := ToStyleStampIndex new .
	idx addProperty: (ToReadOnlyStyleStamp new name: #color1; value: Color blue ).
	idx addProperty: (ToReadOnlyStyleStamp new name: #color2; value: [:e | e defaultColor ] ).
	self assert: (idx hasProperty: (ToReadOnlyStyleStamp  new name: #color1; value: Color blue)).
	self deny: (idx hasProperty: (ToReadOnlyStyleStamp  new name: #color1; value: Color red)).
	self assert: (idx hasProperty: (ToReadOnlyStyleStamp  new name: #color2; value: [:e | e defaultColor ])).
	self deny: (idx hasProperty: (ToReadOnlyStyleStamp  new name: #color2; value: [:e | e color ])).
	self deny: (idx hasProperty: (ToReadOnlyStyleStamp  new name: #color; value: [:e | e color ]))



		
]

{ #category : 'tests' }
ToStyleStampIndexTest >> testInitialize [

	| idx  |
	idx := ToStyleStampIndex new.
	self assert: idx changedAction notNil.
	self assert: idx changedAction isClosure.
		
]

{ #category : 'tests' }
ToStyleStampIndexTest >> testRemoveAllProperties [

	| idx count |
	count := 0.
	idx := ToStyleStampIndex new changedAction: [ count := count + 1 ].
	idx removeAllProperties.
	self assert: count equals: 0.
	idx addAllProperties: {
			(ToReadOnlyStyleStamp new name: #color).
			(ToReadOnlyStyleStamp new name: #background) }.
	self assert: idx size equals: 2.
	self assert: count equals: 1.

	idx removeAllProperties.
	self assert: count equals: 2.
	self assert: idx size equals: 0
]

{ #category : 'tests' }
ToStyleStampIndexTest >> testRemovePropertyNamed [

	| idx count |
	count := 0.
	idx := ToStyleStampIndex new changedAction: [ count := count + 1 ].
	idx addAllProperties: { (ToReadOnlyStyleStamp new name: #color). (ToReadOnlyStyleStamp new name: #background) } .
	self assert: count equals: 1.
	idx removePropertyNamed: #color.
	self assert: count equals: 2.
	idx removePropertyNamed: #color.
	self assert: count equals: 2.
	self deny: (idx hasPropertyNamed: #color)

		
]
