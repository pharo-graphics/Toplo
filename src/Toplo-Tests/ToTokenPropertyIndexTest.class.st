Class {
	#name : #ToTokenPropertyIndexTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-Properties'
}

{ #category : #tests }
ToTokenPropertyIndexTest >> testAddAllProperties [

	| idx count |
	count := 0.
	idx := ToTokenPropertyIndex new changedAction: [ count := count + 1 ].
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: idx size equals: 2.
	self assert: count equals: 1.
	
	" no duplication allowed "
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: idx size equals: 2.
	self assert: count equals: 1

		
]

{ #category : #tests }
ToTokenPropertyIndexTest >> testAddProperty [

	| idx count |
	count := 0.
	idx := ToTokenPropertyIndex new changedAction: [ count := count + 1 ].
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
ToTokenPropertyIndexTest >> testAddPropertyWithBlockClosure [

	| idx count |
	count := 0.
	idx := ToTokenPropertyIndex new changedAction: [ count := count + 1 ].
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
ToTokenPropertyIndexTest >> testChangedAction [

	| idx action |
	idx := ToTokenPropertyIndex new.
	self assert: idx changedAction notNil.
	self assert: idx changedAction isClosure.
	action := [ ].
	idx changedAction: action.
	self assert: idx changedAction identicalTo: action.


		
]

{ #category : #tests }
ToTokenPropertyIndexTest >> testHasProperty [

	| idx  |
	idx := ToTokenPropertyIndex new .
	idx addProperty: (ToTokenProperty new name: #color1; value: Color blue ).
	idx addProperty: (ToTokenProperty new name: #color2; value: [:e | e defaultColor ] ).
	self assert: (idx hasProperty: (ToTokenProperty  new name: #color1; value: Color blue)).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color1; value: Color red)).
	self assert: (idx hasProperty: (ToTokenProperty  new name: #color2; value: [:e | e defaultColor ])).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color2; value: [:e | e color ])).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color; value: [:e | e color ]))



		
]

{ #category : #tests }
ToTokenPropertyIndexTest >> testInitialize [

	| idx  |
	idx := ToTokenPropertyIndex new.
	self assert: idx changedAction notNil.
	self assert: idx changedAction isClosure.
		
]

{ #category : #tests }
ToTokenPropertyIndexTest >> testRemoveAllProperties [

	| idx count |
	count := 0.
	idx := ToTokenPropertyIndex new changedAction: [ count := count + 1 ].
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
ToTokenPropertyIndexTest >> testRemovePropertyNamed [

	| idx count |
	count := 0.
	idx := ToTokenPropertyIndex new changedAction: [ count := count + 1 ].
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: count equals: 1.
	idx removePropertyNamed: #color.
	self assert: count equals: 2.
	idx removePropertyNamed: #color.
	self assert: count equals: 2.
	self deny: (idx hasPropertyNamed: #color)

		
]
