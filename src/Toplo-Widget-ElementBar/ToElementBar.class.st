Class {
	#name : #ToElementBar,
	#superclass : #ToTripletElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'dataAccessor',
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution'
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

{ #category : #'accessing - selection' }
ToElementBar >> deselectAll [

	self selectionModel deselectAll.
	self notifySelectionChanged
]

{ #category : #'accessing - selection' }
ToElementBar >> deselectIndex: anIndex [

	self selectionModel deselectIndex: anIndex.
	self notifySelectionChanged.

]

{ #category : #'accessing - selection' }
ToElementBar >> deselectIndexes: anArray [

	self selectionModel deselectIndexes: anArray.
	self notifySelectionChanged 
]

{ #category : #accessing }
ToElementBar >> fakeDataItem: aDataItem [

	self nodeContainer fakeDataItem: aDataItem
]

{ #category : #initialization }
ToElementBar >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false.
	nodeAutoDistribution := false.
	self
		vFitContent;
		hMatchParent.
	self middleContainer constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ].

	self addEventHandler: ToElementBarEventHandler new.
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		self flag: 'The width of 8 should be handled via a skin'.
		event placeholder padding: (BlInsets left: 14).
		event placeholder layout alignCenterLeft ]
]

{ #category : #initialization }
ToElementBar >> installNodeContainer [

	self nodeContainer ifNotNil: [
		self nodeContainer onUninstalledIn: self ].
	self middleElement: self newNodeContainer.
		self isHorizontal
		ifTrue: [
			self vFitContent.
			self hMatchParent.
			self middleContainer constraintsDo: [:c | c horizontal matchParent. c vertical fitContent ] ]
		ifFalse: [
			self hFitContent.
			self vMatchParent.
			self middleContainer constraintsDo: [:c | c vertical matchParent. c horizontal fitContent]  ].
	self nodeContainer onInstalledIn: self
]

{ #category : #'instance creation' }
ToElementBar >> newNodeContainer [

	| container |
	container := self nodeContainerClass new id: #nodeContainer;
		  yourself.
	container horizontal: self isHorizontal.
	^ container
]

{ #category : #skin }
ToElementBar >> newRawSkin [ 

	^ ToElementBarSkin new
]

{ #category : #accessing }
ToElementBar >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToElementBar >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution := aBoolean.
	self installNodeContainer.
]

{ #category : #accessing }
ToElementBar >> nodeContainer [

	^ self middleElement 
]

{ #category : #'instance creation' }
ToElementBar >> nodeContainerClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToElementBar >> nodeScrolling [

	^ nodeScrolling 
]

{ #category : #accessing }
ToElementBar >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self installNodeContainer 
]

{ #category : #accessing }
ToElementBar >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToElementBar >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self installNodeContainer 
]

{ #category : #accessing }
ToElementBar >> nodes [

	^ self nodeContainer nodes
]

{ #category : #'accessing - selection' }
ToElementBar >> notifySelectionChanged [

	self dispatchEvent: ToElementBarSelectionChanged new
]

{ #category : #layout }
ToElementBar >> onLayoutOrientationChanged [

	self installNodeContainer 
]

{ #category : #'accessing - selection' }
ToElementBar >> onSelectionChanged [

]

{ #category : #private }
ToElementBar >> refresh [

	self nodeContainer refresh
]

{ #category : #removing }
ToElementBar >> removeNode: aNode [

	| index |
	index := aNode holder position.
	self selectionModel deselectIndex: index.
	self fireEvent: ToElementBarSelectionChanged new
]

{ #category : #'accessing - selection' }
ToElementBar >> selectIndex: anIndex [

	self selectionModel selectIndex: anIndex.
	self notifySelectionChanged
]

{ #category : #'accessing - selection' }
ToElementBar >> selectIndexes: aCollection [

	self selectionModel selectIndexes: aCollection.
	self notifySelectionChanged
]

{ #category : #'accessing - selection' }
ToElementBar >> selectOnlyIndex: anIndex [

	self selectionModel deselectAll.
	self selectionModel selectIndex: anIndex.
	self notifySelectionChanged
]

{ #category : #'accessing - selection' }
ToElementBar >> selectOnlyIndexes: aCollection [

	self selectionModel deselectAll.
	self selectionModel selectIndexes: aCollection.
	self notifySelectionChanged
]

{ #category : #accessing }
ToElementBar >> selectionModel [

	^ self subclassResponsibility 
]

{ #category : #private }
ToElementBar >> showHidePlaceholder [

	self nodes ifEmpty: [
			^ self  showPlaceholder ].
	self  hidePlaceholder
]
