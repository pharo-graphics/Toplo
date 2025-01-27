"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToToggleMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable + TToCheckableOwner',
	#classTraits : 'TToCheckable classTrait + TToCheckableOwner classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'as yet unclassified' }
ToToggleMenuItem >> button: aCheckbox [

	super button: aCheckbox.
	self registerInCheckable 

]

{ #category : #'as yet unclassified' }
ToToggleMenuItem >> buttonClass [

	^ ToToggleButton
]

{ #category : #'as yet unclassified' }
ToToggleMenuItem >> buttonClickEventClass [ 

	^ ToCheckableCheckEvent 
]

{ #category : #'t - checkable - accessing' }
ToToggleMenuItem >> checkableData [

	^ self button checkableData
]

{ #category : #'t - checkable - accessing' }
ToToggleMenuItem >> checkableData: aCheckableData [

	^ self shouldNotImplement 
]

{ #category : #'as yet unclassified' }
ToToggleMenuItem >> closeOnPicking [ 

	^ false
]

{ #category : #skin }
ToToggleMenuItem >> newRawSkin [ 

	^ ToToggleMenuItemSkin new
]
