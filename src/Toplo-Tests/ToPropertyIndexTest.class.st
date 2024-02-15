"
A ToPropertyIndexTest is a test class for testing the behavior of ToPropertyIndex
"
Class {
	#name : #ToPropertyIndexTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-Properties'
}

{ #category : #tests }
ToPropertyIndexTest >> testAddAllProperties [

	| idx |
	idx := ToPropertyIndex new.
	idx addAllProperties: { (ToFeatureProperty new name: #color). (ToFeatureProperty new name: #background) } .
	self assert: idx size equals: 2.
	idx addAllProperties: { (ToFeatureProperty new name: #color). (ToFeatureProperty new name: #background) } .
	self assert: idx size equals: 2.


		
]

{ #category : #tests }
ToPropertyIndexTest >> testAddProperty [

	| idx |
	idx := ToPropertyIndex new.
	idx addProperty: (ToFeatureProperty new name: #color).
	self assert: idx size equals: 1
		
]

{ #category : #tests }
ToPropertyIndexTest >> testHasPropertyNamed [

	| idx |
	idx := ToPropertyIndex new.
	idx addAllProperties: {
			(ToFeatureProperty new name: #color).
			(ToFeatureProperty new name: #background) }.
	self assert: (idx hasPropertyNamed: #color).
	self deny: (idx hasPropertyNamed: #layout)
]

{ #category : #tests }
ToPropertyIndexTest >> testIndex [

	| idx |
	idx := ToPropertyIndex new.
	self assert: idx index notNil.
	
]

{ #category : #tests }
ToPropertyIndexTest >> testIsEmpty [

	| idx |
	idx := ToPropertyIndex new.
	self assert: idx isEmpty.
	self assert: idx size equals: 0.
	idx addAllProperties: { (ToFeatureProperty new name: #color) }.
	self deny: idx isEmpty
]

{ #category : #tests }
ToPropertyIndexTest >> testIsNotEmpty [

	| idx |
	idx := ToPropertyIndex new.
	self deny: idx isNotEmpty.
	self assert: idx size equals: 0.
	idx addAllProperties: { (ToFeatureProperty new name: #color) }.
	self assert: idx isNotEmpty
]

{ #category : #tests }
ToPropertyIndexTest >> testPropertyNamed [

	| idx p |
	idx := ToPropertyIndex new.
	p := ToFeatureProperty new name: #color.
	idx addAllProperties: { p }.
	self assert: (idx propertyNamed: #color) identicalTo: p	.
	self assert: (idx propertyNamed: #layout) isNil
]

{ #category : #tests }
ToPropertyIndexTest >> testPropertyNamedIfAbsent [

	| idx p notFound |
	idx := ToPropertyIndex new.
	p := ToFeatureProperty new name: #color.
	idx addAllProperties: { p }.
	notFound := false.
	idx propertyNamed: #layout ifAbsent: [ notFound := true ].
	self assert: notFound
]

{ #category : #tests }
ToPropertyIndexTest >> testRemoveAllProperties [

	| idx |
	idx := ToPropertyIndex new.
	idx addAllProperties: {
			(ToFeatureProperty new name: #color).
			(ToFeatureProperty new name: #background) }.
	self assert: idx size equals: 2.
	idx removeAllProperties.
	self assert: idx size equals: 0
]

{ #category : #tests }
ToPropertyIndexTest >> testRemovePropertyNamed [

	| idx |
	idx := ToPropertyIndex new.
	idx addAllProperties: { (ToFeatureProperty new name: #color). (ToFeatureProperty new name: #background) } .
	idx removePropertyNamed: #color.
	self assert: idx size equals: 1.
	self deny: (idx hasPropertyNamed: #color)

		
]

{ #category : #tests }
ToPropertyIndexTest >> testSize [

	| idx |
	idx := ToPropertyIndex new.
	self assert: idx size isZero.
	
]
