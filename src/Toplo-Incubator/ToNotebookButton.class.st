Class {
	#name : 'ToNotebookButton',
	#superclass : 'ToGeneralButton',
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'checked',
		'group',
		'checkHandler',
		'innerPane',
		'paneBuilder',
		'closable'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'accessing' }
ToNotebookButton >> body [

	^ self notebook body 
]

{ #category : 'hooks - children' }
ToNotebookButton >> checkableCheckEvent: event [

	self isChecked ifTrue: [
		self onSelected.
		^ self ].
	self onDeselected 
]

{ #category : 'accessing' }
ToNotebookButton >> closable: aBoolean [

	closable := aBoolean.
	aBoolean
		ifTrue: [
			| but |
			but := ToButton new.
			but defaultSkin: ToNotebookInnerCloseButtonSkin new.
			but icon: (ToImage inner: (Smalltalk ui icons iconNamed: #windowClose)).
			but constraintsDo: [ :c | c linear vertical alignCenter ].
			but when: BlClickEvent do: [ :event | self removeFromParent ].
			but id: #innerCloseButton.
			self hasChildren
				ifTrue: [ self addChild: but after: self lastChild ]
				ifFalse: [ self addChild: but as: #innerCloseButton ] ]
		ifFalse: [ self removeChildNamed: #innerCloseButton ]
]

{ #category : 'skin' }
ToNotebookButton >> defaultBorder [

	^ Color veryLightGray alpha: 0.5
]

{ #category : 'skin' }
ToNotebookButton >> defaultGeometry [

	^ self notebook buttonGeometry
]

{ #category : 'skin' }
ToNotebookButton >> hoveredBackground [

	^ Color white
]

{ #category : 'initialization' }
ToNotebookButton >> initialize [

	super initialize.
	closable := false.
	paneBuilder := [ :pane :theNotebook | ]
]

{ #category : 'accessing' }
ToNotebookButton >> innerCloseButton [

	^ self childWithId: #innerCloseButton ifNone: [  ]
]

{ #category : 'skin' }
ToNotebookButton >> installRawStyle [

	super installRawStyle.

	self fitContent.
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self padding: self defaultPadding.
	self border: Color black.
	self geometry: self defaultGeometry.
	
]

{ #category : 'testing' }
ToNotebookButton >> isClosable [

	^ closable
]

{ #category : 'testing' }
ToNotebookButton >> isSelected [

	^ self isChecked
]

{ #category : 'skin' }
ToNotebookButton >> labelPadding [

	^ BlInsets top: 4 left: 10 bottom: 4 right: 10
]

{ #category : 'accessing' }
ToNotebookButton >> labelText: aText [ 
	
	| lab |
	lab := ToLabel text: aText asRopedText.
	self addChild: lab at: 1
]

{ #category : 'skin' }
ToNotebookButton >> newRawSkin [ 

	^ ToNotebookButtonSkin new
]

{ #category : 'accessing' }
ToNotebookButton >> notebook [

	^ self parent notebook
]

{ #category : 'hooks - children' }
ToNotebookButton >> onAddedToParent [

	super onAddedToParent.
	self parent onButtonAdded: self.
	checkHandler := BlEventHandler
		                on: ToCheckableCheckEvent
		                do: [ :event | self checkableCheckEvent: event ].
	self addEventHandler: checkHandler
]

{ #category : 'hooks - children' }
ToNotebookButton >> onDeselected [

	self removeInnerPaneFromBody.
	self notebook applyResizablePanesConfiguration.
	self notebook preservePaneOnSelect ifFalse: [ innerPane := nil ]
]

{ #category : 'hooks - children' }
ToNotebookButton >> onRemovedFromParent: aParentElement [

	self removeEventHandler: checkHandler.
	checkHandler := nil.
	innerPane ifNotNil: [
		self removeInnerPaneFromBody.
		innerPane := nil ].
	aParentElement onButtonRemoved: self.
	super onRemovedFromParent: aParentElement
]

{ #category : 'hooks - children' }
ToNotebookButton >> onSelected [

	(self notebook preservePaneOnSelect and: [ innerPane notNil ])
		ifTrue: [			
			self body addChild: innerPane.
			self notebook applyResizablePanesConfiguration.
			^ self ].
	innerPane := ToPane new
		             matchParent;
		             yourself.
	self paneBuilder value: innerPane value: self body parent.
	self body addChild: innerPane.
	self notebook applyResizablePanesConfiguration.


]

{ #category : 'accessing' }
ToNotebookButton >> paneBuilder [

	^ paneBuilder
]

{ #category : 'accessing' }
ToNotebookButton >> paneBuilder: aValuable [
	"Establish what is my body. When a page is selected in a notebook, it will send `#value:value:` to this factory, 
	with the page pane and the notebook as arguments"

	paneBuilder := aValuable
]

{ #category : 't - checkable - accessing' }
ToNotebookButton >> rawChecked [

	^ checked ifNil: [ checked := false ]
]

{ #category : 't - checkable - accessing' }
ToNotebookButton >> rawChecked: aBoolean [

	checked := aBoolean
]

{ #category : 't - checkable - group' }
ToNotebookButton >> rawGroup [

	^ group
]

{ #category : 't - checkable - group' }
ToNotebookButton >> rawGroup: aGroup [

	group := aGroup
]

{ #category : 'hooks - children' }
ToNotebookButton >> removeInnerPaneFromBody [

	innerPane removeFromParent
]

{ #category : 'testing' }
ToNotebookButton >> selected: aBoolean [

	self checked: aBoolean
]

{ #category : 'skin' }
ToNotebookButton >> selectedBackground [

	^ Color fromHexString: #ffd666
]

{ #category : 't - checkable  - protocol' }
ToNotebookButton >> withIndeterminate [

	^ false
]

{ #category : 't - checkable  - protocol' }
ToNotebookButton >> withIndeterminate: aBoolean [

	Error signal: 'Indeterminate not allowed'
]
