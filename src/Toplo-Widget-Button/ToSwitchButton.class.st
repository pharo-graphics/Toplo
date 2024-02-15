Class {
	#name : #ToSwitchButton,
	#superclass : #ToButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'group',
		'checked'
	],
	#category : 'Toplo-Widget-Button-Switch'
}

{ #category : #accessing }
ToSwitchButton >> checkedContainer [ 

	^ self icon checkedContainer
]

{ #category : #accessing }
ToSwitchButton >> handleCheckedBuilder: aValuable [

	self icon handleCheckedBuilder: aValuable
]

{ #category : #initialization }
ToSwitchButton >> initialize [

	| handler |
	super initialize.
	self icon: ToSwitchIcon new.
	handler := BlEventHandler
		           on: ToCheckableCheckEvent
		           do: [ :event | self icon checked: event current].
	self addEventHandler: handler.
	self checked: false
]

{ #category : #skin }
ToSwitchButton >> newRawSkin [ 

	^ ToSwitchButtonSkin new
]

{ #category : #'t - checkable - accessing' }
ToSwitchButton >> rawChecked [

	^ checked
]

{ #category : #'t - checkable - accessing' }
ToSwitchButton >> rawChecked: aBoolean [

	checked := aBoolean
]

{ #category : #'t - checkable - group' }
ToSwitchButton >> rawGroup [

	^ group
]

{ #category : #'t - checkable - group' }
ToSwitchButton >> rawGroup: aGroup [

	group := aGroup
]

{ #category : #accessing }
ToSwitchButton >> uncheckedContainer [ 

	^ self icon uncheckedContainer
]

{ #category : #'t - checkable  - protocol' }
ToSwitchButton >> withIndeterminate [

	^ false
]

{ #category : #'t - checkable  - protocol' }
ToSwitchButton >> withIndeterminate: aBoolean [

	self shouldNotImplement 
]
