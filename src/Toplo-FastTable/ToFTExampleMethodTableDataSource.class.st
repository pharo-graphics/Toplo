"
I'm an example of fast table, who will use a list of methods as data source elements.

self example1.
self example2.
"
Class {
	#name : #ToFTExampleMethodTableDataSource,
	#superclass : #ToFTSimpleDataSource,
	#category : #'Toplo-FastTable-Examples'
}

{ #category : #'instance creation' }
ToFTExampleMethodTableDataSource class >> for: aClass [
	^ self basicNew
		initializeClass: aClass;
		yourself
]

{ #category : #accessing }
ToFTExampleMethodTableDataSource >> cellColumn: column row: rowIndex [
	column id = '#' ifTrue: [ ^ ToFTCellMorph new addMorph: rowIndex asMorph ].
	column id = 'Name' ifTrue: [ ^ self nameColumn: column row: rowIndex ].
	column id = 'Protocol' ifTrue: [ ^ self protocolColumn: column row: rowIndex ].
	column id = 'Origin' ifTrue: [ ^ self originColumn: column row: rowIndex ].

	self error: 'Invalid column'
]

{ #category : #private }
ToFTExampleMethodTableDataSource >> colorFor: index [
	"index odd ifTrue: [ ^ Smalltalk ui theme lightBackgroundColor ]."
	^Color transparent "Smalltalk ui theme backgroundColor"
]

{ #category : #private }
ToFTExampleMethodTableDataSource >> iconFor: rowIndex [
	^ (self elementAt: rowIndex) actionOn: self
]

{ #category : #initialization }
ToFTExampleMethodTableDataSource >> initializeClass: aClass [
	self initialize.
	self elements: ((aClass allSelectors sorted: [ :a :b | a < b ]) collect: [ :each | ToFTExampleMethodModel method: (aClass lookupSelector: each) ])
]

{ #category : #accessing }
ToFTExampleMethodTableDataSource >> menuColumn: column row: rowIndex [
	rowIndex = 0 ifTrue: [
		"I could answer a menu without selection, but in this case I will just answer nil,
		 which means 'no menu'"
		^ nil ].

	"protocols do not have associated menu"
	column id = 'Name' ifTrue: [ ^ self nameMenuColumn: column row: rowIndex ].
	column id = 'Origin' ifTrue: [ ^ self originMenuColumn: column row: rowIndex ].

	^ nil
]

{ #category : #accessing }
ToFTExampleMethodTableDataSource >> nameColumn: column row: rowIndex [
	^ ToFTCellMorph new
		color: (self colorFor: rowIndex);
		cellInset: 5;
		addMorphBack: (self iconFor: rowIndex) asMorph;
		addMorphBack: (self elementAt: rowIndex) name asStringMorph;
		yourself
]

{ #category : #accessing }
ToFTExampleMethodTableDataSource >> nameMenuColumn: column row: rowIndex [
	| method menu |
	method := (self elementAt: rowIndex) method.
	menu := UIManager default newMenuIn: self table for: self.
	menu add: ('Browse ', (method methodClass name), '>>#', method selector)
		target: method
		selector: #browse.
	menu add: ('Inspect #', (method methodClass name), '>>#', method selector)
		target: method
		selector: #inspect.

	^ menu
]

{ #category : #accessing }
ToFTExampleMethodTableDataSource >> originColumn: column row: rowIndex [
	^ ToFTCellMorph new
		color: (self colorFor: rowIndex);
		addMorph: (self elementAt: rowIndex) origin name asMorph;
		yourself
]

{ #category : #accessing }
ToFTExampleMethodTableDataSource >> originMenuColumn: column row: rowIndex [
	| method menu |
	method := (self elementAt: rowIndex) method.
	menu := UIManager default newMenuIn: self table for: self.
	menu add: ('Browse ', (method methodClass name))
		target: method methodClass
		selector: #browse.

	^ menu
]

{ #category : #accessing }
ToFTExampleMethodTableDataSource >> protocolColumn: column row: rowIndex [
	^ ToFTCellMorph new
		color: (self colorFor: rowIndex);
		addMorph: (self elementAt: rowIndex) protocol asStringMorph;
		yourself
]

{ #category : #accessing }
ToFTExampleMethodTableDataSource >> searchText: aString [
	aString isEmptyOrNil ifTrue: [ ^ #() ].

	self elements withIndexDo: [ :each :index |
		( each name beginsWith: aString)
			ifTrue: [ ^ { index } ] ].
	^ #()
]
