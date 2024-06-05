Class {
	#name : #ToCheckbox,
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

{ #category : #skin }
ToCheckbox >> indeterminateBar [

	^ self childWithId: #'indeterminate-bar' ifNone: [  ]
]

{ #category : #skin }
ToCheckbox >> newRawSkin [ 

	^ ToCheckboxSkin new
]

{ #category : #'t - checkable - accessing' }
ToCheckbox >> rawChecked [

	^ checked ifNil: [ checked := false ]
]

{ #category : #'t - checkable - accessing' }
ToCheckbox >> rawChecked: aBoolean [

	checked := aBoolean
]

{ #category : #'t - checkable - group' }
ToCheckbox >> rawGroup [

	^ group
]

{ #category : #'t - checkable - group' }
ToCheckbox >> rawGroup: aGroup [

	group = aGroup ifTrue: [ ^ self ].
	group := aGroup
]

{ #category : #skin }
ToCheckbox >> uninstallRawStyle [

	super uninstallRawStyle.
	self icon: nil
]

{ #category : #'t - checkable  - protocol' }
ToCheckbox >> withIndeterminate [

	^ withIndeterminate ifNil: [ withIndeterminate:= false ]
]

{ #category : #'t - checkable  - protocol' }
ToCheckbox >> withIndeterminate: aBoolean [

	withIndeterminate:= aBoolean
]
