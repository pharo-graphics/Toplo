Class {
	#name : #ToElementBar,
	#superclass : #ToTripletElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'dataAccessor',
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution',
		'selectionMode'
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

{ #category : #'instance creation' }
ToElementBar >> defaultSelectionMode [

	^ ToListSelectionMode primary
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
	self dataAccessor: ToObservableCollection new.
	self selectionMode: self defaultSelectionMode.
	self addEventHandler: ToElementBarEventHandler new.
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		self flag: 'The width of 14???. It should be handled via a skin'.
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
			self middleContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ] ]
		ifFalse: [
			self middleContainer constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal fitContent ] ].
	self nodeContainer onInstalledIn: self
]

{ #category : #'accessing - selection' }
ToElementBar >> installNodeContainerAndRefresh [

	self installNodeContainer.
	self refresh
]

{ #category : #'instance creation' }
ToElementBar >> newNodeContainer [

	| container |
	container := self nodeContainerClass new id: #nodeContainer;
		  yourself.
	container horizontal: self isHorizontal.
	^ container
]

{ #category : #'instance creation' }
ToElementBar >> newPrimarySelectionModel [

	^ ToPrimarySelectionModel new
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
	self installNodeContainerAndRefresh
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
	self installNodeContainerAndRefresh
]

{ #category : #accessing }
ToElementBar >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToElementBar >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self installNodeContainerAndRefresh
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

	self installNodeContainerAndRefresh
]

{ #category : #'accessing - selection' }
ToElementBar >> onSelectionChanged [

]

{ #category : #'accessing - selection' }
ToElementBar >> refresh [

	self nodeContainer refresh
]

{ #category : #'accessing - selection' }
ToElementBar >> removeNode: aNode [

	| index |
	index := aNode holder position.
	'removeNode: ' trace. index traceCr.
	self selectionModel deselectIndex: index.
	self onSelectionChanged.
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
ToElementBar >> selecter [ 

	^ selectionMode selecter
]

{ #category : #accessing }
ToElementBar >> selectionMode: aSelectionMode [

	selectionMode ifNotNil: [
		selectionMode onUninstalledIn: self ].
	selectionMode := aSelectionMode.
	selectionMode ifNotNil: [
		selectionMode onInstalledIn: self ].
	self dispatchEvent: ToListPrimarySelectionModeChangedEvent new.
	self requestNewSkin
]

{ #category : #accessing }
ToElementBar >> selectionModel [

	^ selectionMode selectionModel
]

{ #category : #private }
ToElementBar >> showHidePlaceholder [

	self nodes ifEmpty: [
			^ self  showPlaceholder ].
	self  hidePlaceholder
]
