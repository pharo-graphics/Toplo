Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'group',
		'checked',
		'withIndeterminate'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #initialization }
ToToggleButton >> initialize [ 

	super initialize.
	self initializeCheckable 
]

{ #category : #skin }
ToToggleButton >> newRawSkin [ 

	^ ToToggleButtonSkin new
]

{ #category : #'t - checkable - accessing' }
ToToggleButton >> rawChecked [

	^ checked ifNil: [ checked := false ]
]

{ #category : #'t - checkable - accessing' }
ToToggleButton >> rawChecked: aBoolean [

	checked := aBoolean
]

{ #category : #'t - checkable - group' }
ToToggleButton >> rawGroup [

	^ group
]

{ #category : #'t - checkable - group' }
ToToggleButton >> rawGroup: aGroup [

	group = aGroup ifTrue: [ ^ self ].
	group := aGroup
]

{ #category : #'t - checkable  - protocol' }
ToToggleButton >> withIndeterminate [

	^ withIndeterminate ifNil: [ withIndeterminate:= false ]
]

{ #category : #'t - checkable  - protocol' }
ToToggleButton >> withIndeterminate: aBoolean [

	withIndeterminate:= aBoolean
]
