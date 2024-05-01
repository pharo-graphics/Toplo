Class {
	#name : #ToElementBar,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#instVars : [
		'headerNodeContainer',
		'selectionModel',
		'dataAccessor',
		'nodeWrapping',
		'nodeScrolling',
		'multipleSelection'
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
	multipleSelection := false.
	nodeWrapping := true.
	nodeScrolling := false.

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

	^ multipleSelection 
]

{ #category : #testing }
ToElementBar >> isSingleSelection [

	^ self isMultipleSelection not
]

{ #category : #accessing }
ToElementBar >> multipleSelection: aBoolean [

	multipleSelection :=  aBoolean.
	headerNodeContainer ifNotNil: [
		headerNodeContainer onUninstalledIn: self.
		headerNodeContainer removeFromParent ].
	headerNodeContainer := self newHeaderNodeContainer.
	headerNodeContainer onInstalledIn: self.
	self addChild: headerNodeContainer
]

{ #category : #'instance creation' }
ToElementBar >> newHeaderNodeContainer [

	| containerClass |
	containerClass := self isMultipleSelection
		                  ifTrue: [
		                  ToMultipleSelectHeaderNodeContainerElement ]
		                  ifFalse: [
		                  ToSingleSelectHeaderNodeContainerElement ].
	^ containerClass new
		  nodeWrapping: nodeWrapping;
		  nodeScrolling: nodeScrolling;
		  yourself
]

{ #category : #accessing }
ToElementBar >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	headerNodeContainer nodeScrolling: aBoolean
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
