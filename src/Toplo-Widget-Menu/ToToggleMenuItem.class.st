"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToToggleMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable + TToCheckableOwner',
	#classTraits : 'TToCheckable classTrait + TToCheckableOwner classTrait',
	#instVars : [
		'closeOnPicking'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - button holder' }
ToToggleMenuItem >> button: aCheckbox [

	super button: aCheckbox.
	self registerInCheckable 

]

{ #category : #'t - button holder' }
ToToggleMenuItem >> buttonClass [

	^ ToToggleButton
]

{ #category : #'t - button holder' }
ToToggleMenuItem >> buttonClickEventClass [ 

	^ ToCheckableChangedEvent 
]

{ #category : #'t - checkable - accessing' }
ToToggleMenuItem >> checkableData [

	^ self button checkableData
]

{ #category : #'t - checkable - accessing' }
ToToggleMenuItem >> checkableData: aCheckableData [

	^ self shouldNotImplement 
]

{ #category : #'t - button holder' }
ToToggleMenuItem >> closeOnPicking [ 

	^ closeOnPicking ifNil: [ closeOnPicking := false ]
]

{ #category : #'t - button holder' }
ToToggleMenuItem >> closeOnPicking: aBoolean [

	closeOnPicking := aBoolean
]

{ #category : #skin }
ToToggleMenuItem >> newRawSkin [ 

	^ ToToggleMenuItemSkin new
]
