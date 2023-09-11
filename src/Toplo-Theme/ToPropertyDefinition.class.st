Class {
	#name : #ToPropertyDefinition,
	#superclass : #Object,
	#instVars : [
		'name',
		'writer',
		'reader'
	],
	#classVars : [
		'DefinitionIndex'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #initialization }
ToPropertyDefinition class >> definitionIndex [

	^ DefinitionIndex
]

{ #category : #initialization }
ToPropertyDefinition class >> initialize [

	DefinitionIndex := IdentityDictionary new.
	self registerProperties
]

{ #category : #'instance creation' }
ToPropertyDefinition class >> name: aName reader: aReadValuable writer: aWriteValuable [

	^ self new
		  name: aName;
		  reader: aReadValuable;
		  writer: aWriteValuable;
		  yourself
]

{ #category : #initialization }
ToPropertyDefinition class >> propertyDefinitions [

	^ {
		  (self
			   name: #background
			   reader: [ :e | e background ]
			   writer: [ :e :v | e background: v ]).
		  (self
			   name: #'background-color'
			   reader: [ :e | e background paint color]
			   writer: [ :e :v | e background: v ]).
		  (self
			   name: #layout
			   reader: [ :e | e layout ]
			   writer: [ :e :v | e layout: v ]).
		  (self
			   name: #'layout-direction'
			   reader: [ :e | e layout direction ]
			   writer: [ :e :v | e layout direction: v ]).
		  (self
			   name: #'layout-orientation'
			   reader: [ :e | e layout orientation ]
			   writer: [ :e :v | e layout orientation: v ]).
		  (self
			   name: #'layout-interspace'
			   reader: [ :e | e layout interspace ]
			   writer: [ :e :v | e layout interspace: v ]) }
]

{ #category : #initialization }
ToPropertyDefinition class >> propertyNamed: aName [

	^ self definitionIndex at: aName ifAbsent: [  ] 
]

{ #category : #initialization }
ToPropertyDefinition class >> registerProperties [

	self propertyDefinitions do: [ :p | self definitionIndex at: p name put: p]
]

{ #category : #accessing }
ToPropertyDefinition >> name [

	^ name
]

{ #category : #accessing }
ToPropertyDefinition >> name: anObject [

	name := anObject
]

{ #category : #operating }
ToPropertyDefinition >> read: anObject [

	^ self reader value: anObject
]

{ #category : #accessing }
ToPropertyDefinition >> reader [

	^ reader
]

{ #category : #accessing }
ToPropertyDefinition >> reader: aValuable [

	reader := aValuable
]

{ #category : #operating }
ToPropertyDefinition >> write: anPropertyValue to: anObject [

	self writer value: anObject value: anPropertyValue
]

{ #category : #accessing }
ToPropertyDefinition >> writer [

	^ writer
]

{ #category : #accessing }
ToPropertyDefinition >> writer: aValuable [

	writer := aValuable
]
