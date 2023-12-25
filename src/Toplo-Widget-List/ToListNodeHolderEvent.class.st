Class {
	#name : #ToListNodeHolderEvent,
	#superclass : #BlEvent,
	#instVars : [
		'holder'
	],
	#category : 'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeHolderEvent >> holder [

	^ holder
]

{ #category : #accessing }
ToListNodeHolderEvent >> holder: anHolder [

	holder := anHolder
]
