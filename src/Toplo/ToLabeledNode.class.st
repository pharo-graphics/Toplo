Class {
	#name : #ToLabeledNode,
	#superclass : #ToWidget,
	#traits : 'TToLabeledIcon + TToClickable',
	#classTraits : 'TToLabeledIcon classTrait + TToClickable classTrait',
	#instVars : [
		'#icon => ToSkinnableSlot',
		'#label => ToSkinnableSlot',
		'#extra => ToSkinnableSlot'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'t - click behavior' }
ToLabeledNode >> client [

	^ self  
]

{ #category : #'t - initialization dresser' }
ToLabeledNode >> defaultDresser [ 

	^ ToLabeledNodeDresser new
]

{ #category : #'t - triplet accessing' }
ToLabeledNode >> first [

	^ icon
]

{ #category : #'t - triplet accessing' }
ToLabeledNode >> first: anElement [

	icon := anElement
]

{ #category : #initialization }
ToLabeledNode >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeTriplet
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeEditable [

	self label ifNotNil: [ :l | l beEditable ]
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeReadOnly [ 

	self label ifNotNil: [ :l | l beReadOnly ]
]

{ #category : #'t - triplet accessing' }
ToLabeledNode >> second [

	^ label
]

{ #category : #'t - triplet accessing' }
ToLabeledNode >> second: anElement [

	label := anElement
]

{ #category : #'t - triplet accessing' }
ToLabeledNode >> third [

	^ extra
]

{ #category : #'t - triplet accessing' }
ToLabeledNode >> third: anElement [

	extra := anElement

]
