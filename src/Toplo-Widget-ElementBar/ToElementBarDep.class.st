Class {
	#name : #ToElementBarDep,
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
ToElementBarDep >> dataAccessor [

	^ dataAccessor
]

{ #category : #accessing }
ToElementBarDep >> dataAccessor: aDataAccessor [

	dataAccessor := aDataAccessor
]

{ #category : #'instance creation' }
ToElementBarDep >> defaultSelectionMode [

	^ ToListSelectionMode primary
]

{ #category : #'accessing - selection' }
ToElementBarDep >> deselectAll [

	self selectionModel deselectAll.
	self notifySelectionChanged
]

{ #category : #'accessing - selection' }
ToElementBarDep >> deselectIndex: anIndex [

	self selectionModel deselectIndex: anIndex.
	self notifySelectionChanged.

]

{ #category : #'accessing - selection' }
ToElementBarDep >> deselectIndexes: anArray [

	self selectionModel deselectIndexes: anArray.
	self notifySelectionChanged 
]

{ #category : #accessing }
ToElementBarDep >> fakeDataItem: aDataItem [

	self innerContainer fakeDataItem: aDataItem
]

{ #category : #initialization }
ToElementBarDep >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false.
	nodeAutoDistribution := false.
	self dataAccessor: ToObservableCollection new.
	self selectionMode: self defaultSelectionMode.
	self addEventHandler: ToElementBarEventHandlerDep new.
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		self flag: 'The width of 14???. It should be handled via a skin'.
		event placeholder padding: (BlInsets left: 14).
		event placeholder layout alignCenterLeft ]
]

{ #category : #accessing }
ToElementBarDep >> innerContainer [

	^ self middleElement 
]

{ #category : #'instance creation' }
ToElementBarDep >> innerContainerClass [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToElementBarDep >> installInnerContainer [

	self innerContainer ifNotNil: [
		self innerContainer onUninstalledIn: self ].
	self middleElement: self newInnerContainer.
	self isHorizontal
		ifTrue: [
			self middleContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ] ]
		ifFalse: [
			self middleContainer constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal fitContent ] ].
	self innerContainer onInstalledIn: self
]

{ #category : #'accessing - selection' }
ToElementBarDep >> installInnerContainerAndRefresh [

	self installInnerContainer.
	self refresh
]

{ #category : #'instance creation' }
ToElementBarDep >> newInnerContainer [

	| container |
	container := self innerContainerClass new id: #innerContainer;
		  yourself.
	container horizontal: self isHorizontal.
	^ container
]

{ #category : #'instance creation' }
ToElementBarDep >> newPrimarySelectionModel [

	^ ToPrimarySelectionModel new
]

{ #category : #skin }
ToElementBarDep >> newRawSkin [ 

	^ ToElementBarSkinDep new
]

{ #category : #accessing }
ToElementBarDep >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToElementBarDep >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution := aBoolean.
	self installInnerContainerAndRefresh
]

{ #category : #accessing }
ToElementBarDep >> nodeScrolling [

	^ nodeScrolling 
]

{ #category : #accessing }
ToElementBarDep >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self installInnerContainerAndRefresh
]

{ #category : #accessing }
ToElementBarDep >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToElementBarDep >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self installInnerContainerAndRefresh
]

{ #category : #accessing }
ToElementBarDep >> nodes [

	^ self innerContainer nodes
]

{ #category : #'accessing - selection' }
ToElementBarDep >> notifySelectionChanged [

	self dispatchEvent: ToElementBarSelectionChangedDep new
]

{ #category : #layout }
ToElementBarDep >> onLayoutOrientationChanged [

	self installInnerContainerAndRefresh
]

{ #category : #'accessing - selection' }
ToElementBarDep >> onSelectionChanged [

]

{ #category : #'accessing - selection' }
ToElementBarDep >> refresh [

	self innerContainer refresh
]

{ #category : #'accessing - selection' }
ToElementBarDep >> removeNode: aNode [

	| index |
	index := aNode holder position.
	self selectionModel deselectIndex: index.
	self onSelectionChanged.
	self fireEvent: ToElementBarSelectionChangedDep new
]

{ #category : #'accessing - selection' }
ToElementBarDep >> selectIndex: anIndex [

	self selectionModel selectIndex: anIndex.
	self notifySelectionChanged
]

{ #category : #'accessing - selection' }
ToElementBarDep >> selectIndexes: aCollection [

	self selectionModel selectIndexes: aCollection.
	self notifySelectionChanged
]

{ #category : #'accessing - selection' }
ToElementBarDep >> selectOnlyIndex: anIndex [

	self selectionModel deselectAll.
	self selectionModel selectIndex: anIndex.
	self notifySelectionChanged
]

{ #category : #'accessing - selection' }
ToElementBarDep >> selectOnlyIndexes: aCollection [

	self selectionModel deselectAll.
	self selectionModel selectIndexes: aCollection.
	self notifySelectionChanged
]

{ #category : #accessing }
ToElementBarDep >> selecter [ 

	^ selectionMode selecter
]

{ #category : #accessing }
ToElementBarDep >> selectionMode: aSelectionMode [

	selectionMode ifNotNil: [
		selectionMode onUninstalledIn: self ].
	selectionMode := aSelectionMode.
	selectionMode ifNotNil: [
		selectionMode onInstalledIn: self ].
	self dispatchEvent: ToListPrimarySelectionModeChangedEvent new.
	self requestNewSkin
]

{ #category : #accessing }
ToElementBarDep >> selectionModel [

	^ selectionMode selectionModel
]

{ #category : #private }
ToElementBarDep >> showHidePlaceholder [

	self nodes ifEmpty: [
			^ self  showPlaceholder ].
	self  hidePlaceholder
]
