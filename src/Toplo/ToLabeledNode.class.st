Class {
	#name : #ToLabeledNode,
	#superclass : #ToWidget,
	#traits : 'TToLabelAndIconWithSkinHolder + TToClickable',
	#classTraits : 'TToLabelAndIconWithSkinHolder classTrait + TToClickable classTrait',
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

{ #category : #initialization }
ToLabeledNode >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeLabeledIconWithSkin
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeEditable [

	self label ifNotNil: [ :l | l beEditable ]
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeReadOnly [ 

	self label ifNotNil: [ :l | l beReadOnly ]
]
