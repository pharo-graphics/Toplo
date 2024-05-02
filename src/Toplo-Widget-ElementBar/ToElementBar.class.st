Class {
	#name : #ToElementBar,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectionModel',
		'dataAccessor',
		'nodeWrapping',
		'nodeScrolling',
		'multipleSelection',
		'nodeContainer'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #accessing }
ToElementBar >> dataAccessor [

	^ dataAccessor
]

{ #category : #accessing }
ToElementBar >> dataAccessor: aDataAccessor [

	dataAccessor := aDataAccessor
]

{ #category : #accessing }
ToElementBar >> fakeDataItem: aDataItem [

	nodeContainer fakeDataItem: aDataItem
]

{ #category : #initialization }
ToElementBar >> initialize [

	super initialize.
	multipleSelection := false.
	nodeWrapping := true.
	nodeScrolling := false.

	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
		
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		self flag: 'The width of 8 should be handled via a skin'.
		event placeholder padding: (BlInsets left: 8).
		event placeholder layout alignCenterLeft ]
]

{ #category : #testing }
ToElementBar >> isMultipleSelection [

	^ multipleSelection 
]

{ #category : #testing }
ToElementBar >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #accessing }
ToElementBar >> multipleSelection: aBoolean [

	multipleSelection :=  aBoolean.
	nodeContainer ifNotNil: [
		nodeContainer onUninstalledIn: self.
		nodeContainer removeFromParent ].
	nodeContainer := self newNodeContainer.
	nodeContainer onInstalledIn: self.
	self addChild: nodeContainer
]

{ #category : #'instance creation' }
ToElementBar >> newMultipleSelectionNodeContainer [

	^  ToMultipleSelectionElementBarNodeContainerElement new
]

{ #category : #'instance creation' }
ToElementBar >> newNodeContainer [

	| container |
	container := self isMultipleSelection
		             ifTrue: [ self newMultipleSelectionNodeContainer ]
		             ifFalse: [ self newSingleSelectionNodeContainer ].
	^ container
		  nodeWrapping: nodeWrapping;
		  nodeScrolling: nodeScrolling;
		  yourself
]

{ #category : #'instance creation' }
ToElementBar >> newSingleSelectionNodeContainer [

	^  ToSingleSelectionElementBarNodeContainerElement new
]

{ #category : #accessing }
ToElementBar >> nodeContainer [

	^ nodeContainer 
]

{ #category : #accessing }
ToElementBar >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	nodeContainer nodeScrolling: aBoolean
]

{ #category : #accessing }
ToElementBar >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	nodeContainer nodeWrapping: aBoolean
]

{ #category : #removing }
ToElementBar >> removeNode: aNode [

	| index |
	index := aNode barHolder position.
	self selectionModel deselectIndex: index.
	self fireEvent: ToSelectSelectionChanged new
]

{ #category : #accessing }
ToElementBar >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToElementBar >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
