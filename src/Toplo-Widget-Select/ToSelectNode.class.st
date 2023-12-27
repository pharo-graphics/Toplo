Class {
	#name : #ToSelectNode,
	#superclass : #ToElement,
	#instVars : [
		'selectHolder',
		'startContainer',
		'middleContainer',
		'endContainer',
		'removable'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #'private configurating' }
ToSelectNode >> addRemoveButton [

	| but | 
	but := ToButton new.
	but defaultSkin: ToTabInnerCloseButtonSkin new.
	but icon:	(ToImage inner: (Smalltalk ui icons iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].
	but addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :event |
				 event consumed: true.
				 self selectHolder listElement deselectIndex: self selectHolder position ]).
	" neutralize mouseUp/mouseDown to avoid unwanted opening/closing of the popup list element"
	but addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent 
			 do: [ :event |
				 event consumed: true ]).
	but addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent 
			 do: [ :event |
				 event consumed: true ]).
	but id: #removeButton.
	self endContainer addChild: but
]

{ #category : #configurating }
ToSelectNode >> beRemovable [

	self removable: true
]

{ #category : #configurating }
ToSelectNode >> beUnremovable [

	self removable: false
]

{ #category : #accessing }
ToSelectNode >> endContainer [

	^ endContainer
]

{ #category : #initialization }
ToSelectNode >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	
	startContainer := ToElement new
		                  fitContent;
		                  layout: BlLinearLayout horizontal;
		                  yourself.
	middleContainer := ToElement new
		                   hMatchParent;
		                   vFitContent;
		                   layout: BlLinearLayout horizontal;
		                   yourself.
	endContainer := ToElement new
		                fitContent;
		                layout: BlLinearLayout horizontal;
		                yourself.
	self addChildren: {
			startContainer.
			middleContainer.
			endContainer }.
	self childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].
	
	removable := false.
	middleContainer padding: (BlInsets left: 3 right: 3).
	self padding: (BlInsets horizontal: 2 vertical: 4).
	self margin: (BlInsets all: 2).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3).
	self fitContent
]

{ #category : #testing }
ToSelectNode >> isRemovable [

	^ removable
]

{ #category : #accessing }
ToSelectNode >> middleContainer [

	^ middleContainer
]

{ #category : #accessing }
ToSelectNode >> removable [

	^ removable 
]

{ #category : #accessing }
ToSelectNode >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable ifTrue: [ self removeRemoveButton ].
	removable := aBoolean.
	removable ifTrue: [ self addRemoveButton ]
	
]

{ #category : #'private configurating' }
ToSelectNode >> removeRemoveButton [

	| but |
	but := self endContainer childWithId: #removeButton.
	but removeFromParent
]

{ #category : #accessing }
ToSelectNode >> selectHolder [

	^ selectHolder 
]

{ #category : #accessing }
ToSelectNode >> selectHolder: aSelectNodeHolder [

	selectHolder := aSelectNodeHolder
]

{ #category : #accessing }
ToSelectNode >> startContainer [

	^ startContainer
]