"
I'm a tab of a tab pane. 
A tab header contains a group of me.
"
Class {
	#name : #ToTab,
	#superclass : #ToGeneralButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'checkHandler',
		'innerPane',
		'paneBuilder',
		'closable',
		'filler',
		'header'
	],
	#category : #'Toplo-Widget-TabPaneDeprecated-Core'
}

{ #category : #testing }
ToTab class >> isDeprecated [ 

	^ true
]

{ #category : #'t - checkable - accessing' }
ToTab >> allowIndeterminate [

	^ false
]

{ #category : #'t - checkable - accessing' }
ToTab >> allowIndeterminate: aBoolean [

	Error signal: 'Indeterminate not allowed'
]

{ #category : #accessing }
ToTab >> body [

	^ self tabsPane body 
]

{ #category : #'hooks - children' }
ToTab >> checkableCheckEvent: event [

	self isChecked ifTrue: [
		self onSelected.
		^ self ].
	self onDeselected 
]

{ #category : #accessing }
ToTab >> closable: aBoolean [

	closable := aBoolean.
	aBoolean
		ifTrue: [
			| but |
			but := ToIconicRemoveButton new.
			but constraintsDo: [ :c | c linear vertical alignCenter ].
			but clickAction: [ :event | self removeFromParent ].
			but id: #innerCloseButton.
			filler size: 10 @ 10.
			self addChild: but after: self lastChild ]
		ifFalse: [
			filler size: 0 @ 0.
			(self childWithId: #innerCloseButton ifNone: [  ]) ifNotNil: [
				:child | child removeFromParent ] ]
]

{ #category : #initialization }
ToTab >> defaultBorder [

	^ Color veryLightGray alpha: 0.5
]

{ #category : #initialization }
ToTab >> defaultGeometry [

	^ self tabsPane tabGeometry
]

{ #category : #accessing }
ToTab >> header [

	^ header
]

{ #category : #accessing }
ToTab >> header: aTabPaneHeader [

	header := aTabPaneHeader 
]

{ #category : #skin }
ToTab >> hoveredBackground [

	^ Color white
]

{ #category : #initialization }
ToTab >> initialize [

	super initialize.
	closable := false.
	paneBuilder := [ :pane :theNotebook | ].
	filler := ToElement new size: 0@0.
	filler id: #filler.
	self addChild: filler.
	self initializeAsCheckable.
	self clickEventClass: ToCheckableChangedEvent.
	
]

{ #category : #accessing }
ToTab >> innerCloseButton [

	^ self childWithId: #innerCloseButton ifNone: [  ]
]

{ #category : #accessing }
ToTab >> innerPane [

	^ innerPane
]

{ #category : #skin }
ToTab >> installRawStyle [

	super installRawStyle.

	self fitContent.
	self constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #testing }
ToTab >> isClosable [

	^ closable
]

{ #category : #testing }
ToTab >> isSelected [

	^ self isChecked
]

{ #category : #skin }
ToTab >> labelPadding [

	^ BlInsets top: 4 left: 10 bottom: 4 right: 10
]

{ #category : #accessing }
ToTab >> labelText: aText [ 
	
	| lab |
	lab := ToLabel text: aText asRopedText.
	self addChild: lab at: 1
]

{ #category : #skin }
ToTab >> newRawSkin [ 

	^ ToTabSkin new
]

{ #category : #'hooks - children' }
ToTab >> onAddedToParent [

	super onAddedToParent.
	self header onTabAdded: self.
	checkHandler := BlEventHandler
		                on: ToCheckableCheckEvent
		                do: [ :event | self checkableCheckEvent: event ].
	self addEventHandler: checkHandler
]

{ #category : #'hooks - children' }
ToTab >> onDeselected [

	self removeInnerPaneFromBody.
	self tabsPane applyResizablePanesConfiguration.
	self tabsPane preservePaneOnSelect ifFalse: [ innerPane := nil ]
]

{ #category : #'hooks - children' }
ToTab >> onRemovedFromParent: aParentElement [

	self removeEventHandler: checkHandler.
	checkHandler := nil.
	innerPane ifNotNil: [
		self removeInnerPaneFromBody.
		innerPane := nil ].
	header onTabRemoved: self.
	super onRemovedFromParent: aParentElement
]

{ #category : #'hooks - children' }
ToTab >> onSelected [

	(self tabsPane preservePaneOnSelect and: [ innerPane notNil ])
		ifTrue: [			
			self body addChild: innerPane.
			self tabsPane applyResizablePanesConfiguration.
			^ self ].
	innerPane := ToPane new
		             matchParent;
		             yourself.
	self paneBuilder value: innerPane value: self tabsPane.
	self body addChild: innerPane.
	self tabsPane applyResizablePanesConfiguration.


]

{ #category : #accessing }
ToTab >> paneBuilder [

	^ paneBuilder
]

{ #category : #accessing }
ToTab >> paneBuilder: aValuable [
	"Establish what is my body. When a page is selected in a notebook, it will send `#value:value:` to this factory, 
	with the page pane and the notebook as arguments"

	paneBuilder := aValuable
]

{ #category : #'hooks - children' }
ToTab >> removeInnerPaneFromBody [

	innerPane ifNil: [ ^ self ].
	innerPane removeFromParent
]

{ #category : #testing }
ToTab >> selected: aBoolean [

	self checked: aBoolean
]

{ #category : #skin }
ToTab >> selectedBackground [

	^ Color fromHexString: #ffd666
]

{ #category : #accessing }
ToTab >> tabsPane [ 

	^ self header parent
]
