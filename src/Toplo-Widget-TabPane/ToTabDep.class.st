Class {
	#name : 'ToTabDep',
	#superclass : 'ToGeneralButton',
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'checked',
		'group',
		'checkHandler',
		'innerPane',
		'paneBuilder',
		'closable',
		'filler',
		'header'
	],
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'accessing' }
ToTabDep >> body [

	^ self tabsPane body 
]

{ #category : 'hooks - children' }
ToTabDep >> checkableCheckEvent: event [

	self isChecked ifTrue: [
		self onSelected.
		^ self ].
	self onDeselected 
]

{ #category : 'accessing' }
ToTabDep >> closable: aBoolean [

	closable := aBoolean.
	aBoolean
		ifTrue: [
			| but |
			but := ToButton new.
			but defaultSkin: ToTabInnerCloseButtonSkin new.
			but icon: (ToImage inner: (Smalltalk ui icons iconNamed: #windowClose)).
			but constraintsDo: [ :c | c linear vertical alignCenter ].
			but when: BlClickEvent do: [ :event | self removeFromParent ].
			but id: #innerCloseButton.
			filler size: 10 @ 10.
			self addChild: but after: self lastChild ]
		ifFalse: [
			filler size: 0 @ 0.
			self removeChildNamed: #innerCloseButton ]
]

{ #category : 'initialization' }
ToTabDep >> defaultBorder [

	^ Color veryLightGray alpha: 0.5
]

{ #category : 'initialization' }
ToTabDep >> defaultGeometry [

	^ self tabsPane tabGeometry
]

{ #category : 'accessing' }
ToTabDep >> header [

	^ header
]

{ #category : 'accessing' }
ToTabDep >> header: aTabPaneHeader [

	header := aTabPaneHeader 
]

{ #category : 'skin' }
ToTabDep >> hoveredBackground [

	^ Color white
]

{ #category : 'initialization' }
ToTabDep >> initialize [

	super initialize.
	closable := false.
	paneBuilder := [ :pane :theNotebook | ].
	filler := ToElement new size: 0@0.
	filler id: #filler.
	self addChild: filler
]

{ #category : 'accessing' }
ToTabDep >> innerCloseButton [

	^ self childWithId: #innerCloseButton ifNone: [  ]
]

{ #category : 'skin' }
ToTabDep >> installRawStyle [

	super installRawStyle.

	self fitContent.
	self constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : 'testing' }
ToTabDep >> isClosable [

	^ closable
]

{ #category : 'testing' }
ToTabDep >> isSelected [

	^ self isChecked
]

{ #category : 'skin' }
ToTabDep >> labelPadding [

	^ BlInsets top: 4 left: 10 bottom: 4 right: 10
]

{ #category : 'accessing' }
ToTabDep >> labelText: aText [ 
	
	| lab |
	lab := ToLabel text: aText asRopedText.
	self addChild: lab at: 1
]

{ #category : 'skin' }
ToTabDep >> newRawSkin [ 

	^ ToTabSkin new
]

{ #category : 'hooks - children' }
ToTabDep >> onAddedToParent [

	super onAddedToParent.
	self header onTabAdded: self.
	checkHandler := BlEventHandler
		                on: ToCheckableCheckEvent
		                do: [ :event | self checkableCheckEvent: event ].
	self addEventHandler: checkHandler
]

{ #category : 'hooks - children' }
ToTabDep >> onDeselected [

	self removeInnerPaneFromBody.
	self tabsPane applyResizablePanesConfiguration.
	self tabsPane preservePaneOnSelect ifFalse: [ innerPane := nil ]
]

{ #category : 'hooks - children' }
ToTabDep >> onRemovedFromParent: aParentElement [

	self removeEventHandler: checkHandler.
	checkHandler := nil.
	innerPane ifNotNil: [
		self removeInnerPaneFromBody.
		innerPane := nil ].
	header onTabRemoved: self.
	super onRemovedFromParent: aParentElement
]

{ #category : 'hooks - children' }
ToTabDep >> onSelected [

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

{ #category : 'accessing' }
ToTabDep >> paneBuilder [

	^ paneBuilder
]

{ #category : 'accessing' }
ToTabDep >> paneBuilder: aValuable [
	"Establish what is my body. When a page is selected in a notebook, it will send `#value:value:` to this factory, 
	with the page pane and the notebook as arguments"

	paneBuilder := aValuable
]

{ #category : 't - checkable - accessing' }
ToTabDep >> rawChecked [

	^ checked ifNil: [ checked := false ]
]

{ #category : 't - checkable - accessing' }
ToTabDep >> rawChecked: aBoolean [

	checked := aBoolean
]

{ #category : 't - checkable - group' }
ToTabDep >> rawGroup [

	^ group
]

{ #category : 't - checkable - group' }
ToTabDep >> rawGroup: aGroup [

	group := aGroup
]

{ #category : 'hooks - children' }
ToTabDep >> removeInnerPaneFromBody [

	innerPane removeFromParent
]

{ #category : 'testing' }
ToTabDep >> selected: aBoolean [

	self checked: aBoolean
]

{ #category : 'skin' }
ToTabDep >> selectedBackground [

	^ Color fromHexString: #ffd666
]

{ #category : 'accessing' }
ToTabDep >> tabsPane [ 

	^ self header parent
]

{ #category : 't - checkable  - protocol' }
ToTabDep >> withIndeterminate [

	^ false
]

{ #category : 't - checkable  - protocol' }
ToTabDep >> withIndeterminate: aBoolean [

	Error signal: 'Indeterminate not allowed'
]
