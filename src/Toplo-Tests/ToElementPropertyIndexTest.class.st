Class {
	#name : #ToElementPropertyIndexTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Properties'
}

{ #category : #tests }
ToElementPropertyIndexTest >> testAddAllProperties [

	| idx count |
	count := 0.
	idx := (ToElementPropertyIndex on: ToElement new )
			  addEventHandler: (BlEventHandler
				   on: ToPropertyIndexChangedEvent
				   do: [count := count + 1 ]);
		  yourself.
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: idx size equals: 2.
	self assert: count equals: 1.
	
	" no duplication allowed "
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: idx size equals: 2.
	self assert: count equals: 1

		
]

{ #category : #tests }
ToElementPropertyIndexTest >> testAddProperty [

	| idx count |
	count := 0.
	idx := (ToElementPropertyIndex on: ToElement new )
			  addEventHandler: (BlEventHandler
				   on: ToPropertyIndexChangedEvent
				   do: [count := count + 1 ]);
		  yourself.

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
ToElementPropertyIndexTest >> testAddPropertyWithBlockClosure [

	| idx count |
	count := 0.
	idx := (ToElementPropertyIndex on: ToElement new )
			  addEventHandler: (BlEventHandler
				   on: ToPropertyIndexChangedEvent
				   do: [count := count + 1 ]);
		  yourself.

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
ToElementPropertyIndexTest >> testHasProperty [

	| idx  |
	idx := (ToElementPropertyIndex on: ToElement new ).
	idx addProperty: (ToTokenProperty new name: #color1; value: Color blue ).
	idx addProperty: (ToTokenProperty new name: #color2; value: [:e | e defaultColor ] ).
	self assert: (idx hasProperty: (ToTokenProperty  new name: #color1; value: Color blue)).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color1; value: Color red)).
	self assert: (idx hasProperty: (ToTokenProperty  new name: #color2; value: [:e | e defaultColor ])).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color2; value: [:e | e color ])).
	self deny: (idx hasProperty: (ToTokenProperty  new name: #color; value: [:e | e color ]))



		
]

{ #category : #tests }
ToElementPropertyIndexTest >> testInitialize [

	| idx  |
	idx := ToElementPropertyIndex on: ToElement new		
]

{ #category : #tests }
ToElementPropertyIndexTest >> testRemoveAllProperties [

	| idx count |
	count := 0.
	idx := (ToElementPropertyIndex on: ToElement new )
			  addEventHandler: (BlEventHandler
				   on: ToPropertyIndexChangedEvent
				   do: [count := count + 1 ]);
		  yourself.
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
ToElementPropertyIndexTest >> testRemoveAllPropertiesFromNames [

	| idx count |
	count := 0.
	idx := (ToElementPropertyIndex on: ToElement new )
			  addEventHandler: (BlEventHandler
				   on: ToPropertyIndexChangedEvent
				   do: [count := count + 1 ]);
		  yourself.
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
ToElementPropertyIndexTest >> testRemovePropertyNamed [

	| idx count |
	count := 0.
	idx := (ToElementPropertyIndex on: ToElement new )
			  addEventHandler: (BlEventHandler
				   on: ToPropertyIndexChangedEvent
				   do: [count := count + 1 ]);
		  yourself.
	idx addAllProperties: { (ToTokenProperty new name: #color). (ToTokenProperty new name: #background) } .
	self assert: count equals: 1.
	idx removePropertyNamed: #color.
	self assert: count equals: 2.
	idx removePropertyNamed: #color.
	self assert: count equals: 2.
	self deny: (idx hasPropertyNamed: #color)

		
]
