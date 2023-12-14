Class {
	#name : 'ToToggleButton',
	#superclass : 'ToGeneralButton',
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'checked',
		'group'
	],
	#category : 'Toplo-Widget-Button-Switch',
	#package : 'Toplo-Widget-Button',
	#tag : 'Switch'
}

{ #category : 'initialization' }
ToToggleButton >> initialize [

	super initialize.
	self track: (ToToggleTrackElement new
			 checked: self isChecked;
			 yourself)
]

{ #category : 'accessing' }
ToToggleButton >> innerButton [

	^ self track innerButton
]

{ #category : 't - checkable - accessing' }
ToToggleButton >> rawChecked [

	^ checked ifNil: [ checked := false ]
]

{ #category : 't - checkable - accessing' }
ToToggleButton >> rawChecked: anObject [

	checked := anObject
]

{ #category : 't - checkable - accessing' }
ToToggleButton >> rawGroup [

	^ group
]

{ #category : 't - checkable - accessing' }
ToToggleButton >> rawGroup: aGroup [

	group = aGroup ifNil: [ ^ self ].
	group := aGroup
]

{ #category : 'accessing' }
ToToggleButton >> switchBarOffContainer [

	^ self track switchBarOffContainer
]

{ #category : 'accessing' }
ToToggleButton >> switchBarOffElement: anElement [

	self track switchBarOffElement: anElement
]

{ #category : 'accessing' }
ToToggleButton >> switchBarOnContainer [

	^ self track switchBarOnContainer
]

{ #category : 'accessing' }
ToToggleButton >> switchBarOnElement: anElement [

	self track switchBarOnElement: anElement
]

{ #category : 'accessing' }
ToToggleButton >> switchButtonOffElement [

	^ self track switchButtonOffElement
]

{ #category : 'accessing' }
ToToggleButton >> switchButtonOffElement: anElement [

	^ self track switchButtonOffElement: anElement
]

{ #category : 'accessing' }
ToToggleButton >> switchButtonOnElement [

	^ self track switchButtonOnElement
]

{ #category : 'accessing' }
ToToggleButton >> switchButtonOnElement: anElement [

	self track switchButtonOnElement: anElement
]

{ #category : 'accessing' }
ToToggleButton >> track [

	^ self icon
]

{ #category : 'accessing' }
ToToggleButton >> track: anElement [

	self addChild: ToToggleTrackElement new
]

{ #category : 't - checkable  - protocol' }
ToToggleButton >> withIndeterminate [

	^ false
]

{ #category : 't - checkable  - protocol' }
ToToggleButton >> withIndeterminate: aBoolean [

	self shouldNotImplement 
]
