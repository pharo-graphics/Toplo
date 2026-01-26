"
I am a ToTreeDataSourceWrapper 

My purpose is to wrap an Object (called dataItem) when it is added to a ToTreeDataSource.
"
Class {
	#name : #ToTreeDataItemWrapper,
	#superclass : #ToListDataItemWrapper,
	#instVars : [
		'parentWrapper',
		'isExpanded'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> checkMaxDepth [

	self nodeDepth > 200 ifTrue: [ Error signal: 'Maximum Node deepth reached' ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrapperAt: index [

	| count |
	count := 0.
	self childWrappersDo: [ :w |
		self flag: #todo. "We should not filter"
		w parentWrapper = self ifTrue: [
			count := count + 1.
			count = index ifTrue: [ ^ w ] ] ].

	SubscriptOutOfBounds
		signalFor: index
		lowerBound: 1
		upperBound: count
		in: self
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappers [

	^ Array streamContents: [ :stream |
		  self childWrappersDo: [ :w | stream nextPut: w ] ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappersDo: aBlock [

	self childrenInterval do: [ :p |
		aBlock value: (listElement dataSource at: p) ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappersReverseDo: aBlock [

	| interval |
	interval := self childrenInterval.
	interval last to: interval first by: -1 do: [ :p |
	    aBlock value: (listElement dataSource at: p) ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childrenInterval [

	^ self childrenIntervalFromPosition: self position
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childrenIntervalFromPosition: aPosition [

	| first nb |
	first := aPosition.
	nb := 1.
	[
	first + nb <= listElement dataSource size and: [
		(listElement dataSource at: first + nb) hasParentWrapper: self ] ]
		whileTrue: [ nb := nb + 1 ].
	
	^ first + 1 to: first + nb - 1
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> collapse [

	| childrenInterval pos |
	isExpanded ifFalse: [ ^ self ].
	isExpanded := false.
	pos := self position.
	childrenInterval := self childrenIntervalFromPosition: pos.
	childrenInterval ifEmpty: [ ^ self ].
	listElement dataSource
		removeFrom: childrenInterval first
		to: childrenInterval last.

	self notifyCollapsedAtPosition: pos
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataItemChildren [

	^ listElement nodeManager childrenFromDataItem: self unwrappedDataItem
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> expand [

	| pos children |
	
	isExpanded ifTrue: [ ^ self ].
	self checkMaxDepth.

	isExpanded := true.
	children := self dataItemChildren.
	pos := self position.

	listElement dataAccessor
		useParentWrapper: self
		while: [ listElement dataAccessor addAll: children afterIndex: pos ].

	self notifyExpandedAtPosition: pos
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> expandAll [

	| c pos |
	self collapse.
	pos := self position.
	c := self expandDeeplyIn: OrderedCollection new.
	listElement dataSource addAll: c afterIndex: pos.
	self notifyExpandedAllAtPosition: pos
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> expandDeeplyIn: aCollection [

	| children |
	isExpanded := true.
	self checkMaxDepth.
	children := self dataItemChildren.
	children do: [ :child |
			| wrapper |
			listElement dataAccessor
				useParentWrapper: self
				while: [
						wrapper := listElement dataAccessor newWrapperForDataItem: child.
						aCollection add: wrapper.
						wrapper expandDeeplyIn: aCollection ] ].
	^ aCollection
]

{ #category : #testing }
ToTreeDataItemWrapper >> hasChildWrappers [

	| first |
	first := self position.
	(first + 1 <= listElement dataSource size and: [
		 (listElement dataSource at: first + 1) hasParentWrapper: self ])
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #testing }
ToTreeDataItemWrapper >> hasLeafDataItem [

	^ self dataItem isNotNil and: [ self dataItemChildren isEmpty ]
]

{ #category : #testing }
ToTreeDataItemWrapper >> hasParentWrapper: aDataItemWrapper [

	parentWrapper = aDataItemWrapper ifTrue: [ ^ true ].
	^ parentWrapper
		  ifNil: [ aDataItemWrapper isNil ]
		  ifNotNil: [ parentWrapper hasParentWrapper: aDataItemWrapper ]
]

{ #category : #initialization }
ToTreeDataItemWrapper >> initialize [ 

	super initialize.
	isExpanded := false
]

{ #category : #testing }
ToTreeDataItemWrapper >> isCollapsed [

	^ self isExpanded not
]

{ #category : #testing }
ToTreeDataItemWrapper >> isExpanded [ 

	^ isExpanded ifNil: [ isExpanded := false ]
]

{ #category : #testing }
ToTreeDataItemWrapper >> isExpanded: aBoolean [

	isExpanded := aBoolean
]

{ #category : #testing }
ToTreeDataItemWrapper >> isLeaf [

	self
		deprecated: 'Use #hasLeafDataItem instead'
		transformWith: '`@rcvr isLeaf' -> '`@rcvr hasLeafDataItem'.
	^ self hasLeafDataItem
]

{ #category : #testing }
ToTreeDataItemWrapper >> isRoot [

	^ parentWrapper isNil
]

{ #category : #accessing }
ToTreeDataItemWrapper >> nodeDepth [

	^ parentWrapper
		  ifNil: [ 0 ]
		  ifNotNil: [ parentWrapper nodeDepth + 1 ]
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> notifyCollapsedAtPosition: aPosition [

	" the final step commands include selection updating command 
			that are added when collapsing a tree node.
			They are to be applied now, before the pattern is changed 
			(and then, before the list is changed)"

	listElement consumeFinalStepCommands.
	self updateListAtPosition: aPosition.	
	listElement dispatchEvent: (ToTreeDataItemWrapperCollapsedEvent new
			 wrapper: self;
			 yourself)
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> notifyExpandedAllAtPosition: aPosition [

	" the final step commands include selection updating command 
			that are added when collapsing a tree node.
			They are to be applied now, before the pattern is changed 
			(and then, before the list is changed)"

	listElement consumeFinalStepCommands.
	self updateListAtPosition: aPosition.
	listElement dispatchEvent: (ToTreeDataItemWrapperExpandedEvent new
			 wrapper: self;
			 deeply: true;
			 yourself)
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> notifyExpandedAtPosition: aPosition [

	" the final step commands include selection updating command 
			that are added when collapsing a tree node.
			They are to be applied now, before the pattern is changed 
			(and then, before the list is changed)"

	listElement consumeFinalStepCommands.
	self updateListAtPosition: aPosition.	
	listElement dispatchEvent: (ToTreeDataItemWrapperExpandedEvent new
			 wrapper: self;
			 yourself)
]

{ #category : #accessing }
ToTreeDataItemWrapper >> parentWrapper [ 

	^ parentWrapper 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> parentWrapper: aDataItemWrapper [ 

	parentWrapper := aDataItemWrapper 
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> toggle [

	self isExpanded
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ]
]

{ #category : #accessing }
ToTreeDataItemWrapper >> treeElement: aTreeElement [

	self listElement: aTreeElement
]
