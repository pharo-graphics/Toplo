Class {
	#name : #ToListPrimarySelectionMode,
	#superclass : #ToListRootSelectionMode,
	#instVars : [
		'selectOnPressed',
		'selectOnClick',
		'deselectOnPressed',
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToListPrimarySelectionMode >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListPrimarySelectionMode >> beSingleSelection [

	self multiple: false
]

{ #category : #initialization }
ToListPrimarySelectionMode >> defaultSelectionOption [

	^ ToListSelectionOption new
		  grouped: true;
		  beneath: true;
		  elementFactory: [
			  ToListPrimarySelectionElement new ]
]

{ #category : #accessing }
ToListPrimarySelectionMode >> deselectOnPressed [

	^ deselectOnPressed
]

{ #category : #accessing }
ToListPrimarySelectionMode >> deselectOnPressed: aBoolean [

	deselectOnPressed := aBoolean
]

{ #category : #initialization }
ToListPrimarySelectionMode >> initialize [

	super initialize.
	selectOnPressed := false.
	selectOnClick := true.
	deselectOnPressed := false.
	multiple := true
]

{ #category : #testing }
ToListPrimarySelectionMode >> isMultipleSelection [

	^ multiple
]

{ #category : #testing }
ToListPrimarySelectionMode >> isPrimary [ 

	^ true
]

{ #category : #testing }
ToListPrimarySelectionMode >> minSelectedIndexesCountForSelectionPreserving [

	^ self isMultipleSelection
		       ifTrue: [ 1 ]
		       ifFalse: [ 0 ]
]

{ #category : #accessing }
ToListPrimarySelectionMode >> multiple [

	^ multiple
]

{ #category : #accessing }
ToListPrimarySelectionMode >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter multiple: aBoolean
]

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> newSelecter [

	^ ToPrimarySelecter new
]

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> newSelectionChangedEventHandler [ 

	^ ToListPrimarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> newSelectionModelIn: aListElement [

	^ ToPrimarySelectionModel new
]

{ #category : #accessing }
ToListPrimarySelectionMode >> onAddedNode: aNode [

	aNode clickEventHandlerClass ifNotNil: [ :cls |
		aNode addEventHandler: cls new ]
]

{ #category : #'selection managing' }
ToListPrimarySelectionMode >> onClickEvent: anEvent onMultpleSelectionListNode: aNode [
	" implement the default/standard selection/deselection protocol"

	| index modifiers shift primaryModifier passiveNode |
	index := aNode holder position.
	modifiers := anEvent sourceEvent modifiers.
	shift := modifiers notNil and: [ modifiers isShift ].

	primaryModifier := modifiers notNil and: [
		                   modifiers isPrimaryModifier ].
	" a passive node is a node that can't be selected directly with the mouse.
	As an example, a list that uses a checkbox on each node to drive the selection "
	passiveNode := selectOnPressed not and: [ selectOnClick not ].
	" Shift "
	shift ifTrue: [
			| curr |
			curr := self selecter currentIndex.
			self selecter selectIndex: (curr min: index) to: (index max: curr).
			^ self ].
	" CMD-CTRL "
	(primaryModifier or: [
		 passiveNode or: [ selectOnPressed or: [ deselectOnPressed ] ] ])
		ifTrue: [
				(self selectionModel containsIndex: index)
					ifTrue: [ self selecter deselectIndex: index ]
					ifFalse: [ self selecter selectIndex: index ].
				^ self ].
	" No modifier"
	self selecter selectOnlyIndex: index.
	^ self
]

{ #category : #'selection managing' }
ToListPrimarySelectionMode >> onClickEvent: anEvent onNode: aNode [
	" implement the default/standard selection/deselection protocol"

	self isDisabled ifTrue: [ ^ self ].
	self isMultipleSelection ifTrue: [
		^ self onClickEvent: anEvent onMultpleSelectionListNode: aNode ].
	self onClickEvent: anEvent onSingleSelectionListNode: aNode
]

{ #category : #'selection managing' }
ToListPrimarySelectionMode >> onClickEvent: anEvent onSingleSelectionListNode: aNode [
	" implement the default/standard selection/deselection protocol"

	| index modifiers shift primaryModifier passiveNode |

	index := aNode holder position.
	modifiers := anEvent sourceEvent modifiers.
	shift := modifiers notNil and: [ modifiers isShift ].

	primaryModifier := modifiers notNil and: [
		                   modifiers isPrimaryModifier ].
	" a passive node is a node that can't be selected directly with the mouse.
	As an example, a list that uses a checkbox on each node to drive the selection "
	passiveNode := selectOnPressed not and: [ selectOnClick not ].

	" Single selection "
	" CMD-CTRL  "
	(primaryModifier or: [ passiveNode or: [ selectOnPressed ] ])
		ifTrue: [
				(deselectOnPressed and: [
					 self selectionModel containsIndex: index ]) ifTrue: [
					^ self selecter deselectIndex: index ] ].

	" No modifier"
	self selecter selectOnlyIndex: index
]

{ #category : #accessing }
ToListPrimarySelectionMode >> onRemovedNode: aNode [

	(aNode eventDispatcher handlers select: [ :handler |
		 handler class = aNode clickEventHandlerClass ]) do: [ :handler |
		aNode removeEventHandler: handler ]
]

{ #category : #accessing }
ToListPrimarySelectionMode >> selectOnClick [

	^ selectOnClick
]

{ #category : #accessing }
ToListPrimarySelectionMode >> selectOnClick: aBoolean [

	selectOnClick := aBoolean
]

{ #category : #accessing }
ToListPrimarySelectionMode >> selectOnPressed [

	^ selectOnPressed
]

{ #category : #accessing }
ToListPrimarySelectionMode >> selectOnPressed: aBoolean [

	selectOnPressed := aBoolean
]

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> selectionChangedEventClass [ 

	^ ToListPrimarySelectionChangedEvent
]

{ #category : #accessing }
ToListPrimarySelectionMode >> single: aBoolean [

	self multiple: aBoolean not
]
