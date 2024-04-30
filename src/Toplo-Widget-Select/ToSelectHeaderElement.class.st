Class {
	#name : #ToSelectHeaderElement,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'strategy',
		'windowManager',
		'headerNodeContainer',
		'filtrable',
		'selectionModel',
		'dataAccessor',
		'nodeWrapping'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectHeaderElement >> dataAccessor [

	^ dataAccessor
]

{ #category : #accessing }
ToSelectHeaderElement >> dataAccessor: aDataAccessor [

	dataAccessor := aDataAccessor
]

{ #category : #accessing }
ToSelectHeaderElement >> fakeDataItem: aDataItem [

	headerNodeContainer fakeDataItem: aDataItem
]

{ #category : #accessing }
ToSelectHeaderElement >> filterString [ 

	^ headerNodeContainer filterString
]

{ #category : #accessing }
ToSelectHeaderElement >> filtrable: aBoolean [

	filtrable := aBoolean
]

{ #category : #accessing }
ToSelectHeaderElement >> headerNodeContainer [

	^ headerNodeContainer 
]

{ #category : #initialization }
ToSelectHeaderElement >> initialize [

	super initialize.
	filtrable := true.
	nodeWrapping := true.

	self
		vFitContent;
		hMatchParent;
		id: #headerElement;
		constraintsDo: [ :c | c linear vertical alignCenter ].
		
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		event placeholder padding: (BlInsets left: 5).
		event placeholder layout alignCenterLeft ]
]

{ #category : #testing }
ToSelectHeaderElement >> isFiltrable [ 

	^ filtrable
]

{ #category : #testing }
ToSelectHeaderElement >> isMultipleSelection [

	^ strategy isMultipleSelection
]

{ #category : #testing }
ToSelectHeaderElement >> isSingleSelection [

	^ strategy isSingleSelection
]

{ #category : #'instance creation' }
ToSelectHeaderElement >> newHeaderNodeContainer [

	^ strategy headerNodeContainerClass new
		  id: #headerNodeContainer;
		  nodeWrapping: nodeWrapping;
		  yourself
]

{ #category : #accessing }
ToSelectHeaderElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	headerNodeContainer nodeWrapping: aBoolean
]

{ #category : #window }
ToSelectHeaderElement >> onWindowClosed [

	self headerNodeContainer onWindowClosed
]

{ #category : #window }
ToSelectHeaderElement >> onWindowOpened [

	self headerNodeContainer onWindowOpened
]

{ #category : #accessing }
ToSelectHeaderElement >> pattern [

	self sieve pattern
]

{ #category : #accessing }
ToSelectHeaderElement >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelectHeaderElement >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToSelectHeaderElement >> sieve [

	^ windowManager sieve
]

{ #category : #accessing }
ToSelectHeaderElement >> strategy [

	^ strategy 
]

{ #category : #'api - hooks' }
ToSelectHeaderElement >> strategy: aStrategy [

	strategy := aStrategy.
	headerNodeContainer ifNotNil: [
		headerNodeContainer onUninstalledIn: self.
		headerNodeContainer removeFromParent ].
	headerNodeContainer := self newHeaderNodeContainer.
	headerNodeContainer onInstalledIn: self.
	self addChild: headerNodeContainer
]

{ #category : #accessing }
ToSelectHeaderElement >> textInputElement [ 

	^ headerNodeContainer textInputElement
]

{ #category : #accessing }
ToSelectHeaderElement >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToSelectHeaderElement >> windowManager: aSelectWindowManager [

	windowManager := aSelectWindowManager 
]
