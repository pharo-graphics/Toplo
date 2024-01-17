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
	#category : 'Toplo-Widget-Button-Checkable'
}

{ #category : #skin }
ToCheckbox >> indeterminateChild [

	^ self iconImage childWithId: #bar
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
ToCheckbox >> rawChecked: anObject [

	checked := anObject
]

{ #category : #'t - checkable - group' }
ToCheckbox >> rawGroup [

	^ group
]

{ #category : #'t - checkable - group' }
ToCheckbox >> rawGroup: aGroup [

	group = aGroup ifNil: [ ^ self ].
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
