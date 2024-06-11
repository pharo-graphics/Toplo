Class {
	#name : #ToListSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionMode class >> new [

	^ self shouldNotImplement
]

{ #category : #'instance creation' }
ToListSelectionMode class >> primary [

	| primary |
	primary := self basicNew.
	primary primary: true.
	primary initialize.
	^ primary
]

{ #category : #'instance creation' }
ToListSelectionMode class >> secondary [

	| secondary |
	secondary := self basicNew.
	secondary primary: false.
	secondary initialize.
	^ secondary
]

{ #category : #accessing }
ToListSelectionMode >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListSelectionMode >> beSingleSelection [

	self multiple: false
]

{ #category : #initialization }
ToListSelectionMode >> initialize [

	super initialize.
	multiple := true
]

{ #category : #testing }
ToListSelectionMode >> isMultipleSelection [

	^ multiple
]

{ #category : #testing }
ToListSelectionMode >> maxSelectedIndexesForSelectionPreserving [

	^ self isMultipleSelection
		       ifTrue: [ 1 ]
		       ifFalse: [ 0 ]
]

{ #category : #accessing }
ToListSelectionMode >> multiple [

	^ multiple
]

{ #category : #accessing }
ToListSelectionMode >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter multiple: aBoolean
]

{ #category : #'event handling' }
ToListSelectionMode >> onClickEvent: anEvent onNode: aNode [
	" implement the default/standard selection/deselection protocol"

	self isDisabled ifTrue: [ ^ self ].

	" Multiple selection "
	self isMultipleSelection ifTrue: [ 
		
		" SHIFT "
		anEvent sourceEvent modifiers isShift ifTrue: [
			| curr |
			curr := self selecter currentIndex.
			self selecter selectIndex: curr to: aNode holder position.
			^ self ].
		" CMD-CTRL "
		(anEvent sourceEvent modifiers isPrimaryModifier or: [
			 self selectOnMouseDown ]) ifTrue: [
			self selectOrDeselectOnNode: aNode.
			^ self ].
		" No modifier"
		self selecter selectOnlyIndex: aNode holder position.
		^ self ].

	" Single selection "
	" CMD-CTRL  "
	(anEvent sourceEvent modifiers isPrimaryModifier or: [
		 self selectOnMouseDown ]) ifTrue: [
		| index |
		index := aNode holder position.
		(self selectionModel containsIndex: index) ifTrue: [
			^ self selecter deselectIndex: index ] ].

	" No modifier"
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	selecter
		multiple: self isMultipleSelection
]

{ #category : #'event handling' }
ToListSelectionMode >> selectOrDeselectOnNode: aNode [

	| index target |
	index := aNode holder position.
	target := aNode holder listElement.
	(target selectionModel containsIndex: index)
		ifTrue: [ self selecter deselectIndex: index ]
		ifFalse: [ self selecter selectIndex: index ]
]
