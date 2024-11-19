Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable + TToCheckableOwner',
	#classTraits : 'TToCheckable classTrait + TToCheckableOwner classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
ToCheckMenuItem >> button: aCheckbox [

	super button: aCheckbox.
	self registerInCheckable 

]

{ #category : #initialization }
ToCheckMenuItem >> buttonClass [

	^ ToCheckbox
]

{ #category : #initialization }
ToCheckMenuItem >> buttonClickEventClass [ 

	^ ToCheckableCheckEvent 
]

{ #category : #'t - checkable - accessing' }
ToCheckMenuItem >> checkableData [

	^ self button checkableData
]

{ #category : #'t - checkable - accessing' }
ToCheckMenuItem >> checkableData: aCheckableData [

	^ self shouldNotImplement 
]

{ #category : #testing }
ToCheckMenuItem >> closeOnMouseEvent [

	^ false
]

{ #category : #accessing }
ToCheckMenuItem >> indeterminateBar [

	^ self button indeterminateBar
]

{ #category : #skin }
ToCheckMenuItem >> newRawSkin [ 

	^ ToCheckMenuItemSkin new
]
