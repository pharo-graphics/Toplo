Class {
	#name : #ToLabeledNode,
	#superclass : #ToPairedElement,
	#traits : 'TToLabeledIcon + TToWidgetWithState + TToClickable',
	#classTraits : 'TToLabeledIcon classTrait + TToWidgetWithState classTrait + TToClickable classTrait',
	#category : #'Toplo-Core-Node'
}

{ #category : #'t - click behavior' }
ToLabeledNode >> client [

	^ self holder infiniteElement client
]

{ #category : #'t - initialization dresser' }
ToLabeledNode >> defaultDresser [ 

	^ ToLabeledNodeDresser new
]

{ #category : #initialization }
ToLabeledNode >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	self initializePair
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeEditable [

	self label ifNotNil: [ :l | l beEditable ]
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeReadOnly [ 

	self label ifNotNil: [ :l | l beReadOnly ]
]
