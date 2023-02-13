Class {
	#name : #ToLabeledNode,
	#superclass : #ToWidget,
	#traits : 'TToPair + TToLabeledIcon + TToWidgetWithState + TToClickable + TToSelectableNode',
	#classTraits : 'TToPair classTrait + TToLabeledIcon classTrait + TToWidgetWithState classTrait + TToClickable classTrait + TToSelectableNode classTrait',
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

{ #category : #accessing }
ToLabeledNode >> holder [

	^ self constraints infinite holder
]

{ #category : #initialization }
ToLabeledNode >> initialize [ 

	super initialize.
	self initializePair
]

{ #category : #'t - labeled icon' }
ToLabeledNode >> labelText: aText [

	self label ifNotNil: [ :lab | ^ lab text: aText ].
	self label: (ToLabel text: aText)
]
