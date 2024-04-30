Class {
	#name : #ToElementBar,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'strategy',
		'headerNodeContainer',
		'selectionModel',
		'dataAccessor',
		'nodeWrapping'
	],
	#category : #'Toplo-Widget-Select-Core'
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

	headerNodeContainer fakeDataItem: aDataItem
]

{ #category : #accessing }
ToElementBar >> headerNodeContainer [

	^ headerNodeContainer 
]

{ #category : #initialization }
ToElementBar >> initialize [

	super initialize.
	nodeWrapping := true.

	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
		
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		event placeholder padding: (BlInsets left: 5).
		event placeholder layout alignCenterLeft ]
]

{ #category : #testing }
ToElementBar >> isMultipleSelection [

	^ strategy isMultipleSelection
]

{ #category : #testing }
ToElementBar >> isSingleSelection [

	^ strategy isSingleSelection
]

{ #category : #'instance creation' }
ToElementBar >> newHeaderNodeContainer [

	^ strategy headerNodeContainerClass new
		  nodeWrapping: nodeWrapping;
		  yourself
]

{ #category : #accessing }
ToElementBar >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	headerNodeContainer nodeWrapping: aBoolean
]

{ #category : #accessing }
ToElementBar >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToElementBar >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToElementBar >> strategy [

	^ strategy 
]

{ #category : #'api - hooks' }
ToElementBar >> strategy: aStrategy [

	strategy := aStrategy.
	headerNodeContainer ifNotNil: [
		headerNodeContainer onUninstalledIn: self.
		headerNodeContainer removeFromParent ].
	headerNodeContainer := self newHeaderNodeContainer.
	headerNodeContainer onInstalledIn: self.
	self addChild: headerNodeContainer
]
