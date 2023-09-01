"
! Style classes (==ToStyleClass==)

A style class define a set of properties grouped by a common name. You can think a style class of morphic a little bit as a style class of CSS, but it has several differences.
 
!! Style classes can be nested
You can nest classes to refine some properties. For example, if you have this definition: 

[[[
.application [
	.button [
		Geometry { #height: 25, #width: 100 }
		.smallButton {
			Geometry { #width: 150 }
		}
	]	
]
]]]

the result style for a button with ""smallButton"" style will have a Geometry with the form: ==Geometry { #width: 150, #height: 25 }==, which is the result of the merge of all properties, with the deepest nested property taking precedence.

!! Style classes are composable
You can compose class styles (stacking them to form a new style). This is an useful practice to add your own styles to the default definition.  

[[[language=Smalltalk  
myStyle := ToStyle defaultStyleSheet, myOwnStyleDefinition			
]]]
"
Class {
	#name : #ToClassStyle,
	#superclass : #ToStyle,
	#instVars : [
		'parent',
		'name',
		'styles'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #copying }
ToClassStyle >> , joinStyle [

	^ self mergeWith: joinStyle
]

{ #category : #adding }
ToClassStyle >> addClass: aName with: aBlock [
	| class |
	
	class := self class new
		parent: self;
		name: aName;
		yourself.
	
	aBlock value: class.
	self addStyle: class
]

{ #category : #adding }
ToClassStyle >> addProperty: aClass with: aBlock [ 
	| property |
	
	property := aClass new.
	aBlock value: property.
	self addStyle: property
]

{ #category : #adding }
ToClassStyle >> addPropertyContainerWith: aBlock [ 
	
	self addProperty: ToContainerStyle with: aBlock
]

{ #category : #adding }
ToClassStyle >> addPropertyDrawWith: aBlock [ 
	
	self addProperty: ToDrawStyle with: aBlock
]

{ #category : #adding }
ToClassStyle >> addPropertyFontWith: aBlock [ 
	
	self addProperty: ToFontStyle with: aBlock
]

{ #category : #adding }
ToClassStyle >> addPropertyGeometryWith: aBlock [ 
	
	self addProperty: ToGeometryStyle with: aBlock
]

{ #category : #adding }
ToClassStyle >> addPropertyTextWith: aBlock [ 
	
	self addProperty: ToTextStyle with: aBlock
]

{ #category : #adding }
ToClassStyle >> addStyle: aStyle [

	styles ifNil: [ styles := #() ].
	styles := styles copyWith: aStyle
]

{ #category : #operations }
ToClassStyle >> applyTo: aWidget [

	self properties do: [ :each | 
		each applyTo: aWidget ]
]

{ #category : #accessing }
ToClassStyle >> flattenClasses [

	^ (self styles
		inject: (OrderedCollection with: self)
		into: [ :all :each | 
			each isStyleClass ifTrue: [ all addAll: each flattenClasses ].
			all ])
		flattened
]

{ #category : #accessing }
ToClassStyle >> flattenProperties [

	^ (self flattenClasses
		inject: self properties
		into: [ :all :each | all, each properties ])
		flattened
]

{ #category : #initialization }
ToClassStyle >> fromSton: stonReader [
	
	styles := stonReader parseList
]

{ #category : #accessing }
ToClassStyle >> fullName [

	^ (self parent 
		ifNotNil: [ 
			| parentName |
			parentName := self parent fullName.
			parentName = 'application' 
				ifTrue: [ self name ]
				ifFalse: [ parentName, '.', self name ] ]
		ifNil: [ self name ])
]

{ #category : #initialization }
ToClassStyle >> initialize [

	super initialize.
	styles := #()
]

{ #category : #testing }
ToClassStyle >> isStyleClass [

	^ true
]

{ #category : #copying }
ToClassStyle >> mergeWith: joinStyle [

	^ self class new
		name: name;
		styles: (self mergedStylesWith: joinStyle);
		yourself
]

{ #category : #private }
ToClassStyle >> mergedStylesWith: anotherStyle [

	| allStyles results|
	
	results := OrderedCollection new.
	
	allStyles := (self styles , anotherStyle styles) 
		groupedBy: [:e | e isStyleClass ifTrue: [ e name ] ifFalse: [ e class]].
	
	allStyles valuesDo: [ :value | 
		results add: (value allButFirst inject: value first into: [:accum :each | accum mergeWith: each ])].
	
	^ results asArray
]

{ #category : #accessing }
ToClassStyle >> name [

	^ name
]

{ #category : #accessing }
ToClassStyle >> name: aString [ 
	
	name := aString
]

{ #category : #accessing }
ToClassStyle >> parent [ 

	^ parent
]

{ #category : #accessing }
ToClassStyle >> parent: aStyle [

	parent := aStyle
]

{ #category : #printing }
ToClassStyle >> printOn: stream [ 

	super printOn: stream.
	stream << '(' << self fullName << ')'
]

{ #category : #accessing }
ToClassStyle >> properties [

	^ self styles select: [ :each | each isStyleProperty ]
]

{ #category : #accessing }
ToClassStyle >> styles [

	^ styles
]

{ #category : #private }
ToClassStyle >> styles: aCollection [

	styles := aCollection asArray
]
