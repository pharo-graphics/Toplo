Class {
	#name : #ToToggleMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable + TToCheckableOwner',
	#classTraits : 'TToCheckable classTrait + TToCheckableOwner classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'as yet unclassified' }
ToToggleMenuItem >> button: aCheckbox [

	super button: aCheckbox.
	self registerInCheckable 

]

{ #category : #initialization }
ToToggleMenuItem >> buttonClass [

	^ ToToggleButton
]

{ #category : #initialization }
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
ToToggleMenuItem >> initialize [

	super initialize.
	closeOnPicking := false
]

{ #category : #skin }
ToToggleMenuItem >> newRawSkin [ 

	^ ToToggleMenuItemSkin new
]
