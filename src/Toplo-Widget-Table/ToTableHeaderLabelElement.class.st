"
I represent the label header of a table
"
Class {
	#name : #ToTableHeaderLabelElement,
	#superclass : #ToLabel,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderLabelElement >> initialize [

	super initialize.
	
]

{ #category : #skin }
ToTableHeaderLabelElement >> newRawSkin [ 

	^ ToTableHeaderLabelSkin new
]
