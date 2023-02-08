Class {
	#name : #ToLabeledNode,
	#superclass : #ToWidget,
	#traits : 'TToPair + TToLabeledIcon + TToWidgetWithState + TToClickable + TToSelectableNode',
	#classTraits : 'TToPair classTrait + TToLabeledIcon classTrait + TToWidgetWithState classTrait + TToClickable classTrait + TToSelectableNode classTrait',
	#instVars : [
		'holder'
	],
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

	^ holder
]

{ #category : #accessing }
ToLabeledNode >> holder: anHolder [

	holder := anHolder
]

{ #category : #initialization }
ToLabeledNode >> initialize [ 

	super initialize.
	self initializePair.
	self initializeDresser
]

{ #category : #'t - labeled icon' }
ToLabeledNode >> labelText: aText [

	self label ifNotNil: [ :lab | ^ lab text: aText ].
	self label: (ToLabel text: aText)
]
