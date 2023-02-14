Class {
	#name : #ToLabeledNode,
	#superclass : #ToWidget,
	#traits : 'TToPair + TToLabeledIcon + TToWidgetWithState + TToClickable',
	#classTraits : 'TToPair classTrait + TToLabeledIcon classTrait + TToWidgetWithState classTrait + TToClickable classTrait',
	#category : #'Toplo-Core-Node'
}

{ #category : #'t - click behavior' }
ToLabeledNode >> client [

	^ self holder infiniteElement client
]

{ #category : #'t - initialization dresser' }
ToLabeledNode >> defaultDresser [ 

	^ ToNodeDresser new
]

{ #category : #'private-change' }
ToLabeledNode >> editabilityChanged [

	self isEditable
		ifTrue: [ self privateBeEditable ]
		ifFalse: [ self privateBeReadOnly ]
]

{ #category : #accessing }
ToLabeledNode >> holder [

	^ self constraints infinite holder
]

{ #category : #initialization }
ToLabeledNode >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	self initializePair
]

{ #category : #'t - labeled icon' }
ToLabeledNode >> label: aLabel [

	self second: aLabel
]

{ #category : #'t - labeled icon' }
ToLabeledNode >> labelText: aText [

	self label ifNotNil: [ :lab | ^ lab text: aText ].
	self label: (ToLabel text: aText)
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeEditable [

	self label ifNotNil: [ :l | l beEditable ]
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeReadOnly [ 

	self label ifNotNil: [ :l | l beReadOnly ]
]
