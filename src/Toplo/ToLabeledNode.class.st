Class {
	#name : #ToLabeledNode,
	#superclass : #ToWidget,
	#traits : 'TToLabeled + TToWidgetWithState + TToClickable',
	#classTraits : 'TToLabeled classTrait + TToWidgetWithState classTrait + TToClickable classTrait',
	#instVars : [
		'holder'
	],
	#category : #'Toplo-Core-Node'
}

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
	self initializeLabeled.
	self initializeDresser
]
