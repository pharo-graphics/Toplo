Class {
	#name : #ToNodeHolderEvent,
	#superclass : #BlEvent,
	#instVars : [
		'holder'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #accessing }
ToNodeHolderEvent >> holder [

	^ holder
]

{ #category : #accessing }
ToNodeHolderEvent >> holder: anHolder [

	holder := anHolder
]
